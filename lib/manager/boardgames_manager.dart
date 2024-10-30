// Copyright (C) 2024 Rudson Alves
//
// This file is part of bgbazzar.
//
// bgbazzar is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// bgbazzar is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with bgbazzar.  If not, see <https://www.gnu.org/licenses/>.

import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../common/abstracts/data_result.dart';
import '../common/models/bg_name.dart';
import '../common/models/boardgame.dart';
import '../get_it.dart';
import '../services/parse_server_server.dart';
import '../common/utils/utils.dart';
import '../repository/parse_server/ps_boardgame_repository.dart';
import '../repository/sqlite/bg_names_repository.dart';

class BoardgamesManager {
  final parseServer = getIt<ParseServerService>();

  final List<BGNameModel> _bgs = [];

  List<BGNameModel> get bgs => _bgs;
  List<String> get bgNames => _bgs.map((bg) => bg.name!).toList();

  Future<void> init() async {
    await getBGNames();
  }

  Future<DataResult<void>> getBGNames() async {
    _getLocalBgNames();
    // FIXME: Check is have news bgNames
    // get news bgNames from Parse Server
    final result = await _getParseBgNames();
    if (result.isFailure) {
      return DataResult.failure(GenericFailure(
        message: result.error.toString(),
      ));
    }
    final newsBGNames = result.data!;

    final psBGIds = _bgs.map((bg) => bg.bgId!).toList();
    for (final bg in newsBGNames) {
      if (!psBGIds.contains(bg.bgId!)) {
        final newBg = await SqliteBGNamesRepository.add(bg);
        _bgs.add(newBg);
      }
    }

    _sortingBGNames();
    return DataResult.success(null);
  }

  Future<DataResult<List<BGNameModel>>> _getParseBgNames() async {
    final bgs = await PSBoardgameRepository.getNames();
    return bgs;
  }

  Future<void> _getLocalBgNames() async {
    final bgs = await SqliteBGNamesRepository.get();
    _bgs.clear();
    if (bgs.isEmpty) return;
    _bgs.addAll(bgs);
    _sortingBGNames();
  }

  String? gameId(String gameName) {
    final id = _bgs
        .firstWhere((bg) => bg.name == gameName, orElse: () => BGNameModel())
        .bgId;
    return id;
  }

  List<BGNameModel> searchName(String name) {
    final result = _bgs.where((bg) => bg.name!.toLowerCase().contains(name));

    return result.toList();
  }

  Future<DataResult<void>> save(BoardgameModel bg) async {
    try {
      String localImagePath = '';
      String convertedImagePath = '';

      if (!bg.image.contains(parseServer.keyParseServerUrl)) {
        if (bg.image.contains('http')) {
          localImagePath = await _downloadImage(bg.image);
        } else {
          localImagePath = bg.image;
        }

        final imageName =
            '${Utils.normalizeFileName(bg.name)}_${bg.publishYear}.jpg';
        convertedImagePath =
            await _convertImageToJpg(localImagePath, imageName);

        bg.image = convertedImagePath;
      }

      final result = await PSBoardgameRepository.save(bg);
      if (result.isFailure) {
        throw Exception(result.error);
      }
      final newBg = result.data;

      if (newBg == null) {
        throw Exception('new bg creating error');
      }

      if (localImagePath.isNotEmpty) {
        await File(localImagePath).delete();
      }
      if (convertedImagePath.isNotEmpty) {
        await File(convertedImagePath).delete();
      }

      final bgName = BGNameModel(
        bgId: newBg.id,
        name: '${newBg.name} (${newBg.publishYear})',
      );
      SqliteBGNamesRepository.add(bgName);
      _bgs.add(bgName);
      _sortingBGNames();
      return DataResult.success(null);
    } catch (err) {
      final message = 'BoardgameManager.save: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  Future<DataResult<void>> update(BoardgameModel bg) async {
    try {
      String localImagePath = '';
      String convertedImagePath = '';

      if (!bg.image.contains(parseServer.keyParseServerImageUrl)) {
        if (bg.image.contains('http')) {
          localImagePath = await _downloadImage(bg.image);
        } else {
          localImagePath = bg.image;
        }

        final imageName = '${bg.name}_${bg.publishYear}.jpg';
        convertedImagePath =
            await _convertImageToJpg(localImagePath, imageName);

        bg.image = convertedImagePath;
      }

      final result = await PSBoardgameRepository.update(bg);
      if (result.isFailure) {
        throw Exception(result.error);
      }
      final newBg = result.data;
      if (newBg == null) {
        throw Exception('new bg creating error');
      }

      if (localImagePath.isNotEmpty) {
        await File(localImagePath).delete();
      }
      if (convertedImagePath.isNotEmpty) {
        await File(convertedImagePath).delete();
      }

      final bgName =
          _bgs.firstWhere((b) => b.bgId == bg.id, orElse: () => BGNameModel());
      if (bgName.id == null) {
        throw Exception('_bgs bgId not found.');
      }

      final name = '${newBg.name} (${newBg.publishYear})';
      if (bgName.name == name) {
        // No need to update the local boardgame list
        return DataResult.success(null);
      }

      bgName.name = name;

      SqliteBGNamesRepository.update(bgName);

      final index = _bgs.indexWhere((b) => b.bgId == bg.id);
      if (index == -1) {
        throw Exception('_bgs index not found.');
      }
      _bgs[index].name = bgName.name;
      _sortingBGNames();
      return DataResult.success(null);
    } catch (err) {
      final message = 'BoardgamesManager.update: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  Future<String> _convertImageToJpg(String imagePath, String imageName) async {
    try {
      final image = img.decodeImage(File(imagePath).readAsBytesSync());
      if (image == null) {
        throw Exception('Failed to decode image');
      }

      final resizedImage = img.copyResize(image, width: 800, height: 800);

      final directory = await getApplicationDocumentsDirectory();
      final newPath = join(directory.path, imageName);

      File(newPath).writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85));

      return newPath;
    } catch (err) {
      throw Exception('Error converting image: $err');
    }
  }

  Future<String> _downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to download image');
      }
      final directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, basename(url));
      final file = File(path);
      await file.writeAsBytes(response.bodyBytes);
      return path;
    } catch (err) {
      throw Exception('Error downloading image: $err');
    }
  }

  Future<DataResult<BoardgameModel?>> getBoardgameId(String bgId) async {
    return await PSBoardgameRepository.getById(bgId);
  }

  void _sortingBGNames() {
    List<String> names = bgNames;
    names.sort();
    final List<BGNameModel> sortBGList = [];
    for (final name in names) {
      sortBGList.add(_bgs.firstWhere((m) => m.name == name));
    }
    _bgs.clear();
    _bgs.addAll(sortBGList);
  }
}

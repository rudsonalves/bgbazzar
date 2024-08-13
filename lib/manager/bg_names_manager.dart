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

import '../common/models/bg_name.dart';
import '../common/models/boardgame.dart';
import '../common/settings/local_server.dart';
import '../repository/parse_server/boardgame_repository.dart';

class BgNamesManager {
  final List<BGNameModel> _bgs = [];

  List<BGNameModel> get bgs => _bgs;
  List<String> get bgNames => _bgs.map((bg) => bg.name!).toList();

  Future<void> init() async {
    await getBGNames();
  }

  Future<void> getBGNames() async {
    // FIXME: esta lista deve ser baixada do parse server apenas se houver novas
    //        informações, e somente as novas informações.
    final bgNames = await BoardgameRepository.getNames();
    _bgs.clear();
    if (bgNames.isNotEmpty) {
      _bgs.addAll(bgNames);
    }
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

  Future<void> saveNewBoardgame(BoardgameModel bg) async {
    try {
      String localImagePath = '';
      String convertedImagePath = '';

      if (!bg.image.contains(LocalServer.keyParseServerUrl)) {
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

      final newBg = await BoardgameRepository.save(bg);
      if (newBg == null) {
        throw Exception('new bg creating error');
      }

      if (localImagePath.isNotEmpty) {
        await File(localImagePath).delete();
      }
      if (convertedImagePath.isNotEmpty) {
        await File(convertedImagePath).delete();
      }

      _bgs.add(BGNameModel(
        bgId: newBg.id,
        name: '${newBg.name} (${newBg.publishYear})',
      ));
    } catch (err) {
      log(err.toString());
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
}

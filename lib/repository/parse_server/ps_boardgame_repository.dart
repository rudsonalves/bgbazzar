// ignore_for_file: public_member_api_docs, sort_constructors_first
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

import 'dart:io';

import 'package:bgbazzar/repository/parse_server/common/ps_functions.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:path/path.dart';

import '/repository/interfaces/i_boardgame_repository.dart';
import '../../common/abstracts/data_result.dart';
import '../../common/models/bg_name.dart';
import '../../common/models/boardgame.dart';
import 'common/constants.dart';
import 'common/parse_to_model.dart';

/// This class provides methods to interact with the Parse Server
/// to retrieve and save boardgames informations
class PSBoardgameRepository implements IBoardgameRepository {
  @override
  Future<DataResult<BoardgameModel?>> save(BoardgameModel bg) async {
    try {
      final parseUser = await PsFunctions.parseCurrentUser();
      final parseAcl = PsFunctions.createDefaultAcl(parseUser);
      final parseImage = await _saveImage(path: bg.image, parseUser: parseUser);

      final parseBg = _prepareBgForSaveOrUpdate(
        bg: bg,
        parseImage: parseImage,
        parseAcl: parseAcl,
      );

      final response = await parseBg.save();
      if (!response.success) {
        throw BoardgameRepositoryException(
            response.error?.message ?? 'Failed to save ad.');
      }

      return DataResult.success(ParseToModel.boardgameModel(parseBg));
    } catch (err) {
      return _handleError('save', err);
    }
  }

  @override
  Future<DataResult<BoardgameModel?>> update(BoardgameModel bg) async {
    try {
      final parseUser = await PsFunctions.parseCurrentUser();
      final parseImage = await _saveImage(path: bg.image, parseUser: parseUser);
      final parseAcl = PsFunctions.createDefaultAcl(parseUser);

      final parseBg = _prepareBgForSaveOrUpdate(
        bg: bg,
        parseImage: parseImage,
        parseAcl: parseAcl,
      );

      final response = await parseBg.update();
      if (!response.success) {
        throw BoardgameRepositoryException(
            response.error?.toString() ?? 'unknow error');
      }

      return DataResult.success(ParseToModel.boardgameModel(parseBg));
    } catch (err) {
      return _handleError('update', err);
    }
  }

  @override
  Future<DataResult<BoardgameModel?>> getById(String bgId) async {
    try {
      final parse = ParseObject(keyBgTable);

      final response = await parse.getObject(bgId);
      if (!response.success ||
          response.results == null ||
          response.results!.isEmpty) {
        throw BoardgameRepositoryException(
            response.error?.toString() ?? 'no data found');
      }

      final resultParse = response.results!.first as ParseObject;

      return DataResult.success(ParseToModel.boardgameModel(resultParse));
    } catch (err) {
      return _handleError('getById', err);
    }
  }

  @override
  Future<DataResult<List<BGNameModel>>> getNames() async {
    try {
      final query = QueryBuilder<ParseObject>(ParseObject(keyBgTable));

      query.keysToReturn([keyBgName, keyBgPublishYear]);

      final response = await query.query();
      if (!response.success) {
        throw BoardgameRepositoryException(
            response.error?.toString() ?? 'unknow error');
      }

      if (response.results == null) {
        return DataResult.success([]);
      }

      List<BGNameModel> bgs = [];
      for (final ParseObject p in response.results!) {
        final bg = ParseToModel.bgNameModel(p);
        bgs.add(bg);
      }
      return DataResult.success(bgs);
    } catch (err) {
      return _handleError('getNames', err);
    }
  }

  /// Prepares a ParseObject for saving or updating an ad.
  ///
  /// [bg] - The BoardgameModel with boardgame information.
  /// [parseImage] - The list of ParseFiles representing the ad images.
  /// [parseAcl] - Optional ACL for the ad.
  ParseObject _prepareBgForSaveOrUpdate({
    required BoardgameModel bg,
    required ParseFile parseImage,
    ParseACL? parseAcl,
  }) {
    final ParseObject parseBg;
    if (bg.id == null) {
      parseBg = ParseObject(keyBgTable);
    } else {
      parseBg = ParseObject(keyBgTable)..objectId = bg.id!;
    }

    if (parseAcl != null) {
      parseBg.setACL(parseAcl);
    }

    parseBg
      ..set<String>(keyBgName, bg.name)
      ..set<ParseFile>(keyBgImage, parseImage)
      ..set<int>(keyBgPublishYear, bg.publishYear)
      ..set<int>(keyBgMinPlayers, bg.minPlayers)
      ..set<int>(keyBgMaxPlayers, bg.maxPlayers)
      ..set<int>(keyBgMinTime, bg.minTime)
      ..set<int>(keyBgMaxTime, bg.maxTime)
      ..set<int>(keyBgMinAge, bg.minAge)
      ..set<String?>(keyBgDesigner, bg.designer)
      ..set<String?>(keyBgArtist, bg.artist)
      ..set<String?>(keyBgDescription, bg.description)
      ..set<List<String>>(keyBgMechanics, bg.mechsPsIds);

    return parseBg;
  }

  Future<ParseFile> _saveImage({
    required String path,
    required ParseUser parseUser,
  }) async {
    try {
      // Check if the path is a local file path or an existing URL
      if (!path.startsWith('http')) {
        // Create ParseFile from the local file path
        final parseImage = ParseFile(File(path), name: basename(path));
        parseImage.setACL(PsFunctions.createDefaultAcl(parseUser));

        // Save the file to the Parse server
        final response = await parseImage.save();
        if (!response.success) {
          throw BoardgameRepositoryException(
              response.error?.message ?? 'Failed to save file: $path');
        }

        return parseImage;
      }
      // If it's already a URL, create a ParseFile pointing to that URL
      return ParseFile(null, name: basename(path), url: path);
    } catch (err) {
      throw BoardgameRepositoryException('_saveImages: $err');
    }
  }

  DataResult<T> _handleError<T>(String module, Object error) {
    return PsFunctions.handleError<T>('PSBoardgameRepository', module, error);
  }
}

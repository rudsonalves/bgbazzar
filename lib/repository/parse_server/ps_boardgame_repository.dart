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

import 'dart:developer';
import 'dart:io';

import 'package:bgbazzar/common/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../common/models/bg_name.dart';
import '../../common/models/boardgame.dart';
import 'common/constants.dart';
import 'common/parse_to_model.dart';

class PSBoardgameRepository {
  static Future<BoardgameModel?> save(BoardgameModel bg) async {
    try {
      final parse = ParseObject(keyBgTable);

      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('Current user access error');
      }

      final parseImage = await _saveImage(
        path: bg.image,
        parseUser: parseUser,
        fileName: '${Utils.normalizeFileName(bg.name)}_${bg.publishYear}.jpg',
      );

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);

      parse
        ..setACL(parseAcl)
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
        ..set<int?>(keyBgViews, bg.views)
        ..set<List<String>>(keyBgMechanics, bg.mechsPsIds);

      final response = await parse.save();
      if (!response.success) {
        throw Exception(response.error);
      }

      return ParseToModel.boardgameModel(parse);
    } catch (err) {
      final message = 'AdRepository.save: $err';
      log(message);
      return null;
    }
  }

  static Future<BoardgameModel?> update(BoardgameModel bg) async {
    try {
      final parse = ParseObject(keyBgTable);

      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('Current user access error');
      }

      final parseImage = await _saveImage(
        path: bg.image,
        parseUser: parseUser,
        fileName: '${Utils.normalizeFileName(bg.name)}_${bg.publishYear}.jpg',
      );

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);

      parse
        ..objectId = bg.bgId
        ..setACL(parseAcl)
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
        ..set<int?>(keyBgViews, bg.views)
        ..set<List<String>>(keyBgMechanics, bg.mechsPsIds);

      final response = await parse.update();
      if (!response.success) {
        throw Exception(response.error);
      }

      return ParseToModel.boardgameModel(parse);
    } catch (err) {
      final message = 'AdRepository.save: $err';
      log(message);
      return null;
    }
  }

  static Future<BoardgameModel?> getById(String bgId) async {
    try {
      final parse = ParseObject(keyBgTable);

      final response = await parse.getObject(bgId);
      if (!response.success ||
          response.results == null ||
          response.results!.isEmpty) {
        throw Exception(response.error ?? 'no data found');
      }

      final resultParse = response.results!.first as ParseObject;

      return ParseToModel.boardgameModel(resultParse);
    } catch (err) {
      final message = 'BgRepository.getById: $err';
      log(message);
      rethrow;
    }
  }

  static Future<List<BGNameModel>> getNames() async {
    try {
      final query = QueryBuilder<ParseObject>(ParseObject(keyBgTable));

      query.keysToReturn([keyBgName, keyBgPublishYear]);

      final response = await query.query();
      if (!response.success) {
        throw Exception(response.error);
      }

      if (response.results == null) {
        return [];
      }

      List<BGNameModel> bgs = [];
      for (final ParseObject p in response.results!) {
        final bg = ParseToModel.bgNameModel(p);
        bgs.add(bg);
      }
      return bgs;
    } catch (err) {
      final message = 'BgRepository.getNames: $err';
      log(message);
      rethrow;
    }
  }

  static Future<ParseFile> _saveImage({
    required String path,
    required ParseUser parseUser,
    required String fileName,
  }) async {
    try {
      late ParseFile parseFile;

      if (!path.contains(RegExp(r'http'))) {
        final file = File(path);
        parseFile = ParseFile(file, name: fileName);

        final acl = ParseACL(owner: parseUser);
        acl.setPublicReadAccess(allowed: true);
        acl.setPublicWriteAccess(allowed: false);

        parseFile.setACL(acl);

        final response = await parseFile.save();
        if (!response.success) {
          log('Error saving file: ${response.error}');
          throw Exception(response.error);
        }

        if (parseFile.url == null) {
          throw Exception('failed to get URL after saving the file');
        }
      } else {
        parseFile = ParseFile(null, name: fileName, url: path);
      }

      return parseFile;
    } catch (err) {
      final message = 'exception in _saveImages: $err';
      log(message);
      throw Exception(message);
    }
  }
}

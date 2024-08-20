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

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../common/models/mechanic.dart';
import 'common/constants.dart';
import 'common/parse_to_model.dart';

class PSMechanicsRepository {
  PSMechanicsRepository._();

  static Future<MechanicModel?> add(MechanicModel mech) async {
    try {
      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('Current user access error');
      }

      final parse = ParseObject(keyMechTable);

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl
        ..setPublicReadAccess(allowed: true)
        ..setPublicWriteAccess(allowed: false);

      parse
        ..setACL(parseAcl)
        ..set<String>(keyMechName, mech.name)
        ..set<String>(keyMechDescription, mech.description!);

      final response = await parse.save();
      if (!response.success) {
        final message = 'parse.save error: ${response.error?.message}';
        log(message);
        throw Exception(message);
      }

      return ParseToModel.mechanic(parse);
    } catch (err) {
      final message = 'AdRepository.save: $err';
      log(message);
      return null;
    }
  }

  static Future<List<MechanicModel>> get() async {
    final query = QueryBuilder<ParseObject>(ParseObject(keyMechTable));

    try {
      final response = await query.query();
      if (!response.success) {
        final message = 'parse.get error: ${response.error?.message}';
        log(message);
        throw Exception(message);
      }

      final List<MechanicModel> mechs = [];
      for (final ParseObject parse in response.results!) {
        final mech = ParseToModel.mechanic(parse);
        mechs.add(mech);
      }
      return mechs;
    } catch (err) {
      final message = 'AdRepository.get: $err';
      log(message);
      return [];
    }
  }

  static Future<List<String>> getPsIds() async {
    final query = QueryBuilder<ParseObject>(ParseObject(keyMechTable));

    try {
      query.keysToReturn([keyMechObjectId]);

      final response = await query.query();
      if (!response.success) {
        final message = 'parse.getIds error: ${response.error?.message}';
        log(message);
        throw Exception(message);
      }

      final List<String> mechs = [];
      for (final ParseObject parse in response.results!) {
        final id = parse.objectId;
        mechs.add(id!);
      }
      return mechs;
    } catch (err) {
      final message = 'AdRepository.getIds: $err';
      log(message);
      return [];
    }
  }
}

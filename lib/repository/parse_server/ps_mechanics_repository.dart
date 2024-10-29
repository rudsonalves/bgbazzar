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

import '../../common/abstracts/data_result.dart';
import '../../common/models/mechanic.dart';
import '../interfaces/i_mechanic_repository.dart';
import 'common/constants.dart';
import 'common/parse_to_model.dart';

class PSMechanicsRepository implements IMechanicRepository {
  @override
  Future<DataResult<MechanicModel>> add(MechanicModel mech) async {
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
        throw Exception(response.error?.message);
      }

      return DataResult.success(ParseToModel.mechanic(parse));
    } catch (err) {
      return _handleError('add', err);
    }
  }

  @override
  Future<DataResult<MechanicModel>> update(MechanicModel mech) async {
    try {
      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('Current user access error');
      }

      final parse = ParseObject(keyMechTable)
        // ..objectId = mech.psId // Definir o objectId antes de criar
        ..set<String>(keyMechName, mech.name)
        ..set<String>(keyMechDescription, mech.description!);

      // Definir ACL (opcional, mas recomendado)
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl
        ..setPublicReadAccess(allowed: true)
        ..setPublicWriteAccess(allowed: false);
      parse.setACL(parseAcl);

      // Tentar criar o objeto com o objectId fornecido
      final response = await parse.update();

      if (!response.success) {
        throw Exception(response.error?.message);
      }

      return DataResult.success(ParseToModel.mechanic(parse));
    } catch (err) {
      return _handleError('update', err);
    }
  }

  @override
  Future<DataResult<List<MechanicModel>>> getAll() async {
    final query = QueryBuilder<ParseObject>(ParseObject(keyMechTable));

    try {
      final response = await query.query();
      if (!response.success) {
        throw Exception(response.error);
      }

      final List<MechanicModel> mechs = [];
      for (final ParseObject parse in response.results!) {
        final mech = ParseToModel.mechanic(parse);
        mechs.add(mech);
      }
      return DataResult.success(mechs);
    } catch (err) {
      return _handleError('getAll', err);
    }
  }

  @override
  Future<DataResult<MechanicModel>> get(String psId) async {
    try {
      final parse = ParseObject(keyMechTable);
      final response = await parse.getObject(psId);

      if (!response.success) {
        throw Exception(response.error);
      }
      if (response.results == null) {
        throw Exception('not found mech.id: $psId');
      }

      final MechanicModel mechanic = ParseToModel.mechanic(
        response.results!.first as ParseObject,
      );

      return DataResult.success(mechanic);
    } catch (err) {
      return _handleError('getById', err);
    }
  }

  @override
  Future<DataResult<List<String>>> getIds() async {
    final query = QueryBuilder<ParseObject>(ParseObject(keyMechTable));

    try {
      query.keysToReturn([keyMechObjectId]);

      final response = await query.query();
      if (!response.success) {
        throw Exception(response.error?.message);
      }

      final List<String> mechs = [];
      for (final ParseObject parse in response.results!) {
        final id = parse.objectId;
        mechs.add(id!);
      }
      return DataResult.success(mechs);
    } catch (err) {
      return _handleError('getIds', err);
    }
  }

  DataResult<T> _handleError<T>(String message, Object error) {
    final fullMessage = 'MechanicsRepository.$message: $error';
    log(fullMessage);
    return DataResult.failure(GenericFailure(message: fullMessage));
  }
}

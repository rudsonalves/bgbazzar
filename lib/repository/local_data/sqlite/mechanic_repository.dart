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

import '/store/stores/interfaces/i_mechanics_store.dart';
import '/core/abstracts/data_result.dart';
import '/core/models/mechanic.dart';
import '/store/stores/mechanics_store.dart';
import '../interfaces/i_local_mechanic_repository.dart';

class SqliteMechanicRepository implements ILocalMechanicRepository {
  final IMechanicsStore _store = MechanicsStore();

  @override
  Future<void> initialize() async {
    _store.initialize();
  }

  @override
  Future<DataResult<List<MechanicModel>>> getAll() async {
    try {
      final result = await _store.getAll();
      if (result.isEmpty) DataResult.success([]);

      final mechanics =
          result.map((item) => MechanicModel.fromMap(item)).toList();
      return DataResult.success(mechanics);
    } catch (err) {
      final message = 'MechanicRepository.get: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  @override
  Future<DataResult<MechanicModel>> add(MechanicModel mech) async {
    try {
      final id = await _store.add(mech.toMap());
      if (id < 0) throw Exception('return id $id');

      return DataResult.success(mech);
    } catch (err) {
      final message = 'MechanicRepository.add: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  @override
  Future<DataResult<void>> update(MechanicModel mech) async {
    try {
      await _store.update(mech.toMap());
      return DataResult.success(null);
    } catch (err) {
      final message = 'MechanicRepository.update: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  @override
  Future<DataResult<void>> delete(String id) async {
    try {
      final result = await _store.delete(id);
      if (result < 0) {
        throw Exception('mechanic id $id not found.');
      }
      return DataResult.success(null);
    } catch (err) {
      final message = 'MechanicRepository.delete: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  @override
  Future<DataResult<void>> resetDatabase() async {
    try {
      await _store.resetDatabase();
      return DataResult.success(null);
    } catch (err) {
      final message = 'MechanicRepository.resetDatabase: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }
}

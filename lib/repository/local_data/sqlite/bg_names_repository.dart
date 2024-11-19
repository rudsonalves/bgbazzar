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

import '../../../core/abstracts/data_result.dart';
import '/get_it.dart';
import '/core/models/bg_name.dart';
import '/store/stores/interfaces/i_bg_names_store.dart';
import '../interfaces/i_bg_names_repository.dart';

class SqliteBGNamesRepository implements IBgNamesRepository {
  late final IBgNamesStore _store;

  @override
  Future<void> initialize() async {
    _store = await getIt.getAsync<IBgNamesStore>();
  }

  @override
  Future<DataResult<List<BGNameModel>>> getAll() async {
    try {
      final result = await _store.getAll();
      if (result.isEmpty) {
        return DataResult.success([]);
      }

      final bgs = result.map((item) => BGNameModel.fromMap(item)).toList();
      return DataResult.success(bgs);
    } catch (err) {
      final message = 'BGNamesRepository.get: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  @override
  Future<DataResult<BGNameModel>> add(BGNameModel bg) async {
    try {
      final id = await _store.add(bg.toMap());
      if (id < 0) throw Exception('retrun id $id');

      return DataResult.success(bg);
    } catch (err) {
      final message = 'BGNamesRepository.add: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  @override
  Future<DataResult<void>> delete(String bgId) async {
    try {
      final id = await _store.delete(bgId);
      if (id < 1) {
        throw Exception('record not found');
      }
      return DataResult.success(null);
    } catch (err) {
      final message = 'BGNamesRepository.delete: $err';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  @override
  Future<DataResult<int>> update(BGNameModel bg) async {
    try {
      final result = await _store.update(bg.toMap());
      return DataResult.success(result);
    } catch (err) {
      final message = 'BGNamesRepository.update: $err';
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

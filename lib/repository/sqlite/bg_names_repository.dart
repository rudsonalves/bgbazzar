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

import '../../store/stores/bg_names_store.dart';
import '/common/models/bg_name.dart';
import 'local_interfaces/i_bg_names_repository.dart';

class SqliteBGNamesRepository implements IBgNamesRepository {
  @override
  Future<List<BGNameModel>> getAll() async {
    try {
      final result = await BGNamesStore.getAll();
      if (result.isEmpty) return [];

      final bgs = result.map((item) => BGNameModel.fromMap(item)).toList();
      return bgs;
    } catch (err) {
      final message = 'BGNamesRepository.get: $err';
      log(message);
      throw Exception(message);
    }
  }

  @override
  Future<BGNameModel> add(BGNameModel bg) async {
    try {
      final id = await BGNamesStore.add(bg.toMap());
      if (id < 0) throw Exception('retrun id $id');

      return bg;
    } catch (err) {
      final message = 'BGNamesRepository.add: $err';
      log(message);
      throw Exception(message);
    }
  }

  @override
  Future<int> update(BGNameModel bg) async {
    try {
      final result = await BGNamesStore.update(bg.toMap());
      return result;
    } catch (err) {
      final message = 'BGNamesRepository.update: $err';
      log(message);
      throw Exception(message);
    }
  }
}

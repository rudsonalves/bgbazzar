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

import '../../get_it.dart';
import '../constants/constants.dart';
import '../database/database_manager.dart';

class BGNamesStore {
  static final _databaseManager = getIt<DatabaseManager>();

  static Future<List<Map<String, dynamic>>> getAll() async {
    final database = await _databaseManager.database;

    try {
      List<Map<String, dynamic>> result = await database.query(
        bgNamesTable,
        orderBy: bgName,
      );

      return result;
    } catch (err) {
      log('BGNamesStore.get: $err');
      return [];
    }
  }

  static Future<int> add(Map<String, dynamic> map) async {
    final database = await _databaseManager.database;

    try {
      final id = await database.insert(
        bgNamesTable,
        map,
      );
      if (id < 0) {
        throw Exception('id return $id');
      }
      return id;
    } catch (err) {
      log('BGNamesStore.add: $err');
      return -1;
    }
  }

  static Future<int> update(Map<String, dynamic> map) async {
    final database = await _databaseManager.database;

    try {
      final result = await database.update(
        bgNamesTable,
        map,
      );

      return result;
    } catch (err) {
      log('BGNamesStore.update: $err');
      return -1;
    }
  }
}

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

import '../get_it.dart';
import 'constants/constants.dart';
import 'database_manager.dart';

class MechanicsStore {
  static final _databaseManager = getIt<DatabaseManager>();

  static Future<List<Map<String, dynamic>>> queryMechs() async {
    final database = await _databaseManager.database;

    try {
      List<Map<String, dynamic>> result = await database.query(
        mechTable,
        columns: [mechId, mechName, mechDescription],
        orderBy: mechName,
      );

      return result;
    } catch (err) {
      log('MechanicsStore.queryMechs: $err');
      return [];
    }
  }

  static Future<int> add(Map<String, dynamic> map) async {
    final database = await _databaseManager.database;

    try {
      final result = await database.insert(
        mechTable,
        map,
      );

      return result;
    } catch (err) {
      log('MechanicsStore.add: $err');
      return -1;
    }
  }

  static Future<int> update(Map<String, dynamic> map) async {
    final database = await _databaseManager.database;

    try {
      final result = await database.update(
        mechTable,
        map,
      );

      return result;
    } catch (err) {
      log('MechanicsStore.add: $err');
      return -1;
    }
  }

  static Future<int> delete(int id) async {
    final database = await _databaseManager.database;

    try {
      final result = await database.delete(
        mechTable,
        where: '$mechId: ?',
        whereArgs: [id],
      );

      return result;
    } catch (err) {
      log('MechanicsStore.add: $err');
      return -1;
    }
  }
}

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

class BggRankStore {
  static final _databaseManager = getIt<DatabaseManager>();

  static Future<List<Map<String, dynamic>>> queryRankGameNames(int year) async {
    final database = await _databaseManager.database;

    try {
      List<Map<String, dynamic>> result = await database.query(
        rankTable,
        columns: [rankId, rankGameName],
        where: '$rankYearPublished > ?',
        whereArgs: [year],
        orderBy: rankGameName,
      );

      return result;
    } catch (err) {
      log('Error: $err');
      return [];
    }
  }

  static Future<Map<String, dynamic>> queryRankFromId(int id) async {
    final database = await _databaseManager.database;

    try {
      List<Map<String, dynamic>> result = await database
          .query(rankTable, where: '$rankId = ?', whereArgs: [id]);

      if (result.isEmpty) return {};
      return result.first;
    } catch (err) {
      log('Error: $err');
      return {};
    }
  }
}

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

class MechStore {
  static final _databaseManager = getIt<DatabaseManager>();

  static Future<List<Map<String, dynamic>>> queryMechs(
      [String langCode = 'pt_BR']) async {
    final database = await _databaseManager.database;

    final getColumns = (langCode != 'pt_BR')
        ? [mechId, mechName, mechDescription]
        : [mechId, mechNome, mechDescricao];
    final orderByName = (langCode != 'pt_BR') ? mechName : mechNome;
    try {
      List<Map<String, dynamic>> result = await database.query(
        mechTable,
        columns: getColumns,
        orderBy: orderByName,
      );

      return result;
    } catch (err) {
      log('Error: $err');
      return [];
    }
  }

  static Future<String> queryDescription(int id,
      [String langCode = 'pt_BR']) async {
    final database = await _databaseManager.database;
    final getColumn = (langCode != 'pt_BR') ? mechDescription : mechDescricao;
    try {
      final result = await database.query(
        mechTable,
        columns: [getColumn],
        where: '$mechId = ?',
        whereArgs: [id],
      );

      if (result.isEmpty) return '';
      return result[0][getColumn] as String;
    } catch (err) {
      log('Error: $err');
      return '';
    }
  }
}

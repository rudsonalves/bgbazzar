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

import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class SqlTable {
  SqlTable._();

  static createBgNamesTable(Batch batch) {
    batch.execute(
      'CREATE TABLE IF NOT EXISTS $bgNamesTable ('
      '   $bgId	TEXT PRIMARY KEY NOT NULL,'
      '   $bgName	TEXT NOT NULL'
      ')',
    );
  }

  static createDbVersion(Batch batch) {
    batch.execute(
      'CREATE TABLE IF NOT EXISTS $dbVersionTable ('
      '  $dbVersionId	INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
      '  $dbAppVersion	INTEGER NOT NULL,'
      '  $dbBGVersion	INTEGER NOT NULL DEFAULT 0,'
      '  $dbBGList	TEXT NOT NULL DEFAULT "[]"'
      ')',
    );
  }

  static createMechanics(Batch batch) {
    batch.execute(
      'CREATE TABLE IF NOT EXISTS $mechTable ('
      '  $mechId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
      '  $mechName TEXT NOT NULL UNIQUE,'
      '  $mechDescription TEXT NOT NULL'
      ')',
    );
  }

  static dropMechanics(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $mechTable');
  }

  static dropBgNamesTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $bgNamesTable');
  }
}

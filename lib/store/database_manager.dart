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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'constants/constants.dart';

class DatabaseManager {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> databaseClose() async {
    if (_database != null) {
      await _database!.close();
    }
    _database = null;
  }

  Future<Database> _initDatabase() async {
    String basePath = '';
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      basePath = 'App/bgBazzar';
    } else if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    final baseDir = await getApplicationDocumentsDirectory();
    final directory =
        basePath.isEmpty ? baseDir : Directory(join(baseDir.path, basePath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    final path = join(directory.path, dbName);

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      await _copyBggDb(path);
    }

    _database = await openDatabase(path);

    final version = await getDBVerion();
    if (version != dbAppVersionValue) {
      _database!.close();
      final dbFile = File(path);
      await dbFile.delete();
      await _copyBggDb(path);
      _database = await openDatabase(path, readOnly: true);
    }

    return _database!;
  }

  Future<void> _copyBggDb(String path) async {
    final file = await File(path).create();
    ByteData data = await rootBundle.load(dbAssertPath);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await file.writeAsBytes(bytes);
  }

  static Future<int?> getDBVerion() async {
    try {
      final result = await _database!.query(
        dbVersionTable,
        columns: [dbAppVersion],
        where: '$dbVersionId = 1',
      );
      return result.first[dbAppVersion] as int;
    } catch (err) {
      return null;
    }
  }
}

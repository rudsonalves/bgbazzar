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

import 'package:shared_preferences/shared_preferences.dart';

import 'i_app_preferences_repository.dart';

class AppSharePreferencesRepository implements IAppPreferencesRepository {
  late final SharedPreferences prefs;
  bool started = false;

  static const keySearchHistory = 'SearchHistory';
  static const keyLocalDBVersion = 'LocalDBVersion';
  static const keyBrightness = 'Brightness';

  @override
  late int dbVersion;

  @override
  late String brightness;

  @override
  late List<String> history;

  @override
  Future<void> initialize() async {
    if (started) return;

    started = true;
    prefs = await SharedPreferences.getInstance();
    dbVersion = prefs.getInt(keyLocalDBVersion) ?? 1000;
    brightness = prefs.getString(keyBrightness) ?? 'dark';
    history = prefs.getStringList(keySearchHistory) ?? [];
  }

  @override
  Future<void> setBright(String value) async {
    brightness = value;
    prefs.setString(keyBrightness, brightness);
  }

  @override
  Future<void> setDBVersion(int value) async {
    dbVersion = value;
    prefs.setInt(keyLocalDBVersion, dbVersion);
  }

  @override
  Future<void> setHistory(List<String> value) async {}
}
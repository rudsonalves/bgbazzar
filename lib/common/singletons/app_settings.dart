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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/shared_preferenses.dart';

class AppSettings {
  final ValueNotifier<Brightness> _brightness =
      ValueNotifier<Brightness>(Brightness.dark);

  int _localDBVersion = 1000;

  ValueNotifier<Brightness> get brightness => _brightness;
  bool get isDark => _brightness.value == Brightness.dark;
  int get localDBVersion => _localDBVersion;

  Future<void> init() async {
    await _readAppSettings();
  }

  Future<void> _readAppSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(keyLocalDBVersion)) {
      _localDBVersion = prefs.getInt(keyLocalDBVersion) ?? 1000;
    }
    if (prefs.containsKey(keyBrightness)) {
      final brightness = prefs.getString(keyBrightness) ?? 'dark';
      _brightness.value =
          brightness == 'dark' ? Brightness.dark : Brightness.light;
    }
  }

  Future<void> _saveBright() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyBrightness, _brightness.value.toString());
  }

  Future<void> setLocalDBVersion(int version) async {
    _localDBVersion = version;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyLocalDBVersion, version);
  }

  void toggleBrightnessMode() {
    _brightness.value = _brightness.value == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    _saveBright();
  }

  void dispose() {
    _brightness.dispose();
  }
}

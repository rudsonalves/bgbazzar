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

class AppSettings {
  AppSettings();

  final ValueNotifier<Brightness> _brightness =
      ValueNotifier<Brightness>(Brightness.dark);

  ValueNotifier<Brightness> get brightness => _brightness;
  bool get isDark => _brightness.value == Brightness.dark;

  void toggleBrightnessMode() {
    _brightness.value = _brightness.value == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
  }

  void setBrightnessMode(Brightness brightness) {
    _brightness.value = brightness;
  }

  void dispose() {
    _brightness.dispose();
  }
}

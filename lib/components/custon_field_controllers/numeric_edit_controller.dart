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

class NumericEditController extends TextEditingController {
  final RegExp reInitZeroNumber = RegExp(r'^0[\d][\.\d]*$');
  String oldValue = '';

  double get numericValue => double.tryParse(text) ?? 0;
  set numericValue(double value) => text = value.toString();

  NumericEditController({double? initialValue}) {
    oldValue = initialValue != null ? initialValue.toString() : '0';
    text = oldValue;
    addListener(_validateNumber);
  }

  void _validateNumber() {
    String newValue = text;

    // Remove spaces
    if (newValue != newValue.trim()) {
      _setControllerText();
      return;
    }

    // Replase empty string by '0'
    if (newValue.isEmpty) {
      oldValue = '0';
      _setControllerText();
      return;
    }

    // Remove zeros from the start of the number ('02' -> '2')
    if (reInitZeroNumber.hasMatch(newValue)) {
      oldValue = newValue.substring(1);
      _setControllerText();
      return;
    }

    // Check if it is a valid number
    final result = double.tryParse(newValue);
    if (result == null) {
      _setControllerText();
      return;
    }

    oldValue = newValue;
  }

  void _setControllerText() {
    text = oldValue;
    selection = TextSelection.fromPosition(
      TextPosition(offset: oldValue.length),
    );
  }
}

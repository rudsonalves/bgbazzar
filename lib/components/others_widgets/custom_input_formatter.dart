// ignore_for_file: public_member_api_docs, sort_constructors_first
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

import 'package:flutter/services.dart';

class CustomInputFormatter extends TextInputFormatter {
  final String mask;

  CustomInputFormatter({
    required this.mask,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    final StringBuffer buffer = StringBuffer();
    int index = 0;
    for (int i = 0; i < digitsOnly.length && index < mask.length; i++) {
      if (mask[index] != '#') {
        buffer.write(mask[index]);
        index++;
        i--;
        continue;
      }
      buffer.write(digitsOnly[i]);
      index++;
    }

    String strBuffer = buffer.toString();

    return TextEditingValue(
      text: strBuffer,
      selection: TextSelection.collapsed(offset: strBuffer.length),
    );
  }
}

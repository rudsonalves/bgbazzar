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
import 'package:material_symbols_icons/symbols.dart';

class StarRatingBar extends StatelessWidget {
  final double rate;

  const StarRatingBar({
    super.key,
    required this.rate,
  });

  List<Widget> _createRateRow(double rate) {
    List<Widget> row = [];

    for (int i = 1; i <= 5; i++) {
      row.add(
        Icon(
          Symbols.star_sharp,
          size: 18,
          color: rate >= i ? Colors.yellow : Colors.grey,
        ),
      );
    }

    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _createRateRow(rate),
    );
  }
}

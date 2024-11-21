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

class StarRatingBar extends StatelessWidget {
  final double rate;

  const StarRatingBar({
    super.key,
    required this.rate,
  });

  List<Widget> _createRateRow(double rate) {
    List<Widget> row = [];
    final note = (rate * 2).round() / 2;
    final size = 18.0;

    for (int i = 1; i < 6; i++) {
      final halfLeft = note > i - 1;
      final halfRight = halfLeft && note >= i;

      if (!halfLeft && !halfRight) {
        row.add(
          Image.asset(
            'assets/images/star_empty.png',
            width: size,
            height: size,
          ),
        );
      } else if (halfLeft && !halfRight) {
        row.add(
          Image.asset(
            'assets/images/star_half.png',
            width: size,
            height: size,
          ),
        );
      } else if (halfLeft && halfRight) {
        row.add(
          Image.asset(
            'assets/images/star_full.png',
            width: size,
            height: size,
          ),
        );
      }
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
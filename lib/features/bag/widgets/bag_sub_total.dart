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

import '/core/theme/app_text_style.dart';

class BagSubTotal extends StatelessWidget {
  final ValueNotifier<int> itemsCount;
  final double Function() total;

  const BagSubTotal({
    super.key,
    required this.itemsCount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: itemsCount,
      builder: (context, count, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Subtotal ($count'
                ' ite${count > 1 ? 'ns' : 'm'}): '),
            Text(
              '\$${total().toStringAsFixed(2)}',
              style: AppTextStyle.font16Bold,
            ),
          ],
        );
      },
    );
  }
}

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

import '../../../core/models/bag_item.dart';
import '../../../data_managers/bag_manager.dart';
import '../../../get_it.dart';

class QuantityButtons extends StatelessWidget {
  final BagItemModel item;

  QuantityButtons({
    super.key,
    required this.item,
  });

  final bagManager = getIt<BagManager>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Material(
                child: InkWell(
                  onTap: () => bagManager.decreaseQt(item.adId),
                  child: ValueListenableBuilder(
                      valueListenable: bagManager.itemsCount,
                      builder: (context, _, __) {
                        return Icon(
                          item.quantity == 1 ? Symbols.delete : Symbols.remove,
                          size: 18,
                        );
                      }),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: bagManager.itemsCount,
              builder: (context, _, __) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(item.quantity.toString()),
              ),
            ),
            ClipOval(
              child: Material(
                child: InkWell(
                  onTap: () => bagManager.increaseQt(item.adId),
                  child: Icon(
                    Symbols.add,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

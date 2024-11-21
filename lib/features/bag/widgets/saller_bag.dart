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

import '../../../core/theme/app_text_style.dart';
import '../../../data_managers/bag_manager.dart';
import '../../../get_it.dart';
import '../bag_controller.dart';
import 'bag_sub_total.dart';
import 'quantity_buttons.dart';

class SallerBag extends StatelessWidget {
  final BagController ctrl;
  final String saller;

  SallerBag({
    super.key,
    required this.ctrl,
    required this.saller,
  });

  final bagManager = getIt<BagManager>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item', style: AppTextStyle.font14Bold),
              Text('Preço', style: AppTextStyle.font14Bold),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: ctrl.items.length,
          itemBuilder: (_, index) {
            final item = ctrl.items[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      width: 80,
                      height: 80,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.network(item.adItem.images.first),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.font16Bold,
                        ),
                        Text(
                          item.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.font12,
                        ),
                        QuantityButtons(
                          item: item,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '\$${item.unitPrice.toStringAsFixed(2)}',
                        style: AppTextStyle.font16Bold,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        Divider(),
        BagSubTotal(
          itemsCount: bagManager.itemsCount,
          total: bagManager.total,
        ),
        FilledButton.icon(
          onPressed: () {},
          label: Text('Proceder para o Pagamento'),
          icon: Icon(Symbols.encrypted_sharp),
        ),
      ],
    );
  }
}

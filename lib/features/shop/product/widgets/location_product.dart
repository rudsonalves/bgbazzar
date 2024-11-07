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

import '../../../../core/models/address.dart';
import 'sub_title_product.dart';

class LocationProduct extends StatelessWidget {
  final AddressModel address;

  const LocationProduct({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleProduct(subtile: 'Endereço'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: ['CEP', 'Cidade', 'Estado']
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Text(e),
                              const Spacer(),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [address.zipCode, address.city, address.state]
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Text(e),
                              const Spacer(),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
        // LocalItemProduct(
        //   title: address.zipCode,
        //   label: 'CEP',
        // ),
        // LocalItemProduct(
        //   title: address.city,
        //   label: 'Município',
        // ),
        // LocalItemProduct(
        //   title: address.state,
        //   label: 'Estado',
        // ),
      ],
    );
  }
}

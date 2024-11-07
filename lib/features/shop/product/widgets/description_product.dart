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

import '../../../../components/texts/read_more_text.dart';
import 'sub_title_product.dart';

class DescriptionProduct extends StatelessWidget {
  final String description;

  const DescriptionProduct({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleProduct(subtile: 'Descrição do Produto:'),
        ReadMoreText(
          description,
          trimMode: TrimMode.line,
          trimLines: 5,
          trimExpandedText: '  [ver menos]',
          trimCollapsedText: '  [ver mais]',
          colorClickableText: colorScheme.primary,
        ),
      ],
    );
  }
}

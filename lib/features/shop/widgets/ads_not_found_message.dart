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

class AdsNotFoundMessage extends StatelessWidget {
  const AdsNotFoundMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Card(
            color: colorScheme.primaryContainer.withOpacity(.45),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Icon(
                    Icons.warning_amber,
                    color: Colors.amber,
                    size: 80,
                  ),
                  Text(
                    'Nenhum anúncio encontrado',
                    style: AppTextStyle.font18Bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

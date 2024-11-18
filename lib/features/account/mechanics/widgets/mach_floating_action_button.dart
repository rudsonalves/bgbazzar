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

import '/core/singletons/current_user.dart';
import '/get_it.dart';

class MechFloatingActionButton extends StatelessWidget {
  final void Function()? onPressBack;
  final void Function()? onPressAdd;
  final void Function()? onPressDeselect;

  const MechFloatingActionButton({
    super.key,
    this.onPressBack,
    this.onPressAdd,
    this.onPressDeselect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OverflowBar(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: FloatingActionButton(
            heroTag: 'hero-0',
            backgroundColor: colorScheme.primaryContainer.withOpacity(0.85),
            onPressed: onPressBack,
            tooltip: 'Voltar',
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        if (getIt<CurrentUser>().isAdmin) ...[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FloatingActionButton(
              heroTag: 'hero-1',
              backgroundColor: colorScheme.primaryContainer.withOpacity(0.85),
              onPressed: onPressAdd,
              tooltip: 'Adicionar',
              child: const Icon(Icons.add),
            ),
          ),
        ],
        FloatingActionButton(
          backgroundColor: colorScheme.primaryContainer.withOpacity(0.85),
          heroTag: 'hero-3',
          onPressed: onPressDeselect,
          tooltip: 'Deselecionar',
          child: const Icon(Icons.deselect),
        ),
      ],
    );
  }
}

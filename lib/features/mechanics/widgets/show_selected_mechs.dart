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

import '../../../common/models/mechanic.dart';

class ShowSelectedMechs extends StatelessWidget {
  final List<MechanicModel> mechanics;
  final bool Function(int) isSelectedIndex;
  final void Function(int) toogleSelectionIndex;

  const ShowSelectedMechs({
    super.key,
    required this.mechanics,
    required this.isSelectedIndex,
    required this.toogleSelectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 70),
      itemCount: mechanics.length,
      separatorBuilder: (context, index) =>
          const Divider(indent: 24, endIndent: 24),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelectedIndex(index) ? colorScheme.tertiaryContainer : null,
        ),
        child: ListTile(
          title: Text(mechanics[index].name),
          subtitle: Text(mechanics[index].description ?? ''),
          onTap: () => toogleSelectionIndex(index),
        ),
      ),
    );
  }
}

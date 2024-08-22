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

class ShowOnlySelectedMechs extends StatelessWidget {
  final List<String> selectedPsIds;
  final MechanicModel Function(String) mechanicOfPsId;
  final void Function(int) toogleSelectedInIndex;
  final bool hideDescription;

  const ShowOnlySelectedMechs({
    super.key,
    required this.selectedPsIds,
    required this.mechanicOfPsId,
    required this.toogleSelectedInIndex,
    this.hideDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 70),
      itemCount: selectedPsIds.length,
      separatorBuilder: (context, index) =>
          const Divider(indent: 24, endIndent: 24),
      itemBuilder: (context, index) {
        final mech = mechanicOfPsId(selectedPsIds[index]);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colorScheme.tertiaryContainer,
          ),
          child: ListTile(
            title: Text(mech.name),
            subtitle: hideDescription ? null : Text(mech.description ?? ''),
            onTap: () => toogleSelectedInIndex(index),
          ),
        );
      },
    );
  }
}

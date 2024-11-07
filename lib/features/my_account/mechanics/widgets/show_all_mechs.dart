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

import '../../../../get_it.dart';
import '../../../../data_managers/mechanics_manager.dart';
import '../mechanics_store.dart';

class ShowAllMechs extends StatefulWidget {
  final MechanicsStore store;

  const ShowAllMechs({
    super.key,
    required this.store,
  });

  @override
  State<ShowAllMechs> createState() => _ShowAllMechsState();
}

class _ShowAllMechsState extends State<ShowAllMechs> {
  final mechanicManager = getIt<MechanicsManager>();
  MechanicsStore get store => widget.store;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mechs = mechanicManager.mechanics;

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 70),
      itemCount: mechs.length,
      separatorBuilder: (context, index) =>
          const Divider(indent: 24, endIndent: 24),
      itemBuilder: (context, index) {
        final mech = mechs[index];
        final isSelected = store.isSelectedId(mech.id!);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? colorScheme.tertiaryContainer : null,
          ),
          child: ValueListenableBuilder(
              valueListenable: store.hideDescription,
              builder: (context, hideDescription, _) {
                return ListTile(
                  title: Text(mech.name),
                  subtitle:
                      hideDescription ? null : Text(mech.description ?? ''),
                  onTap: () {
                    store.setMech(mech);
                    setState(() {});
                  },
                );
              }),
        );
      },
    );
  }
}

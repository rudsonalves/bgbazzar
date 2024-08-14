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

import 'dart:developer';

import 'package:flutter/material.dart';

import '../../common/singletons/current_user.dart';
import '../../components/form_fields/custom_form_field.dart';
import '../../get_it.dart';
import 'mechanics_controller.dart';

class MechanicsScreen extends StatefulWidget {
  final List<int> selectedIds;

  const MechanicsScreen({
    super.key,
    required this.selectedIds,
  });

  static const routeName = '/mechanics';

  @override
  State<MechanicsScreen> createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends State<MechanicsScreen> {
  final ctrl = MechanicsController();

  @override
  void initState() {
    super.initState();

    ctrl.init(widget.selectedIds);
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  void _closeMechanicsPage() {
    Navigator.pop(context, ctrl.selectedIds);
  }

  Future<void> _addMechanic() async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    final result = await showDialog<bool?>(
          context: context,
          builder: (context) => SimpleDialog(
            backgroundColor: colorScheme.surfaceContainerHigh,
            contentPadding: const EdgeInsets.fromLTRB(12, 12.0, 12, 16.0),
            title: const Text('Nova Mecânica'),
            children: [
              CustomFormField(
                controller: nameController,
                labelText: 'Mecânica',
                hintText: 'Adicione um nome para a mecânica',
                fullBorder: false,
              ),
              CustomFormField(
                controller: descriptionController,
                labelText: 'Descrição',
                hintText: 'Adicione uma descrição',
                fullBorder: false,
              ),
              OverflowBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: () => Navigator.pop(context, true),
                    label: const Text('Adicionar'),
                    icon: const Icon(Icons.add),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => Navigator.pop(context, false),
                    label: const Text('Cancelar'),
                    icon: const Icon(Icons.cancel),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;

    if (result) {
      log(nameController.text);
      log(descriptionController.text);
    }

    await Future.delayed(const Duration(milliseconds: 50));
    nameController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mecânicas'),
        centerTitle: true,
        leading: IconButton(
          onPressed: _closeMechanicsPage,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          ValueListenableBuilder(
              valueListenable: ctrl.showSelected,
              builder: (context, value, _) {
                return IconButton(
                  onPressed: ctrl.toogleShowSelection,
                  isSelected: value,
                  icon: const Icon(Icons.ballot_outlined),
                  selectedIcon: const Icon(Icons.ballot_rounded),
                );
              }),
        ],
      ),
      floatingActionButton: OverflowBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          getIt<CurrentUser>().isAdmin
              ? FloatingActionButton.extended(
                  heroTag: 'hero-1',
                  backgroundColor:
                      colorScheme.primaryContainer.withOpacity(0.60),
                  onPressed: _addMechanic,
                  label: const Text('Adicionar'),
                  icon: const Icon(Icons.add),
                )
              : FloatingActionButton.extended(
                  heroTag: 'hero-2',
                  backgroundColor:
                      colorScheme.primaryContainer.withOpacity(0.60),
                  onPressed: _closeMechanicsPage,
                  label: const Text('Voltar'),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
          FloatingActionButton.extended(
            backgroundColor: colorScheme.primaryContainer.withOpacity(0.60),
            onPressed: ctrl.deselectAll,
            icon: const Icon(Icons.deselect),
            label: const Text('Deselecionar'),
          ),
        ],
      ),
      body: Card(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListenableBuilder(
                  listenable:
                      Listenable.merge([ctrl.redraw, ctrl.showSelected]),
                  builder: (context, _) {
                    if (!ctrl.showSelected.value) {
                      return ListView.separated(
                        itemCount: ctrl.mechanics.length,
                        separatorBuilder: (context, index) =>
                            const Divider(indent: 24, endIndent: 24),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ctrl.isSelectedIndex(index)
                                ? colorScheme.tertiary.withOpacity(0.15)
                                : null,
                          ),
                          child: ListTile(
                            title: Text(ctrl.mechanics[index].name),
                            subtitle:
                                Text(ctrl.mechanics[index].description ?? ''),
                            onTap: () => ctrl.toogleSelectionIndex(index),
                          ),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: ctrl.selectedIds.length,
                        separatorBuilder: (context, index) =>
                            const Divider(indent: 24, endIndent: 24),
                        itemBuilder: (context, index) {
                          final mech =
                              ctrl.mechanicOfId(ctrl.selectedIds[index]);
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorScheme.tertiary.withOpacity(0.15),
                            ),
                            child: ListTile(
                              title: Text(mech.name),
                              subtitle: Text(mech.description ?? ''),
                              onTap: () => ctrl.toogleSelectedInIndex(index),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

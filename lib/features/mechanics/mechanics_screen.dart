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

import '/common/singletons/current_user.dart';
import '/components/others_widgets/state_error_message.dart';
import '/components/others_widgets/state_loading_message.dart';
import '/get_it.dart';
import 'mechanics_store.dart';
import 'mechanics_controller.dart';
import 'widgets/mechanic_dialog.dart';
import 'widgets/search_mechs_delegate.dart';
import 'widgets/show_only_selected_mechs.dart';
import 'widgets/show_all_mechs.dart';

class MechanicsScreen extends StatefulWidget {
  final List<String> selectedPsIds;

  const MechanicsScreen({
    super.key,
    required this.selectedPsIds,
  });

  static const routeName = '/mechanics';

  @override
  State<MechanicsScreen> createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends State<MechanicsScreen> {
  final ctrl = MechanicsController();
  final store = MechanicsStore();

  @override
  void initState() {
    super.initState();

    ctrl.init(store, widget.selectedPsIds);
  }

  @override
  void dispose() {
    store.dispose();

    super.dispose();
  }

  void _closeMechanicsPage() {
    Navigator.pop(context, store.selectedMechIds);
  }

  Future<void> _addMechanic() async {
    final mech = await MechanicDialog.open(context);
    if (mech != null) ctrl.add(mech);
  }

  Future<void> _removeMechanic() async {
    final result = await showDialog<bool?>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Remover Mecânica'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Remover as mecânicas selecionadas?'),
              ],
            ),
            actions: [
              FilledButton.tonalIcon(
                onPressed: () => Navigator.pop(context, false),
                label: Text('Remover'),
              ),
              FilledButton.tonalIcon(
                onPressed: () => Navigator.pop(context, false),
                label: Text('Cancelar'),
              ),
            ],
          ),
        ) ??
        false;
    if (result) {
      log('ctrl.remove(mech)');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: store.state,
      builder: (context, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: ValueListenableBuilder(
                    valueListenable: store.counter,
                    builder: (context, value, _) {
                      return Text('Mecânicas [$value]');
                    }),
                centerTitle: true,
                leading: IconButton(
                  onPressed: _closeMechanicsPage,
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SearchMechsDelegate(
                          ctrl.selectMechByName,
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                  ValueListenableBuilder(
                      valueListenable: store.hideDescription,
                      builder: (context, hideDescription, _) {
                        return IconButton(
                          onPressed: store.toggleHideDescription,
                          tooltip: hideDescription
                              ? 'Mostrar Descrição'
                              : 'Ocultar Descrição',
                          icon: Icon(
                            hideDescription
                                ? Icons.description_outlined
                                : Icons.insert_drive_file_outlined,
                          ),
                        );
                      }),
                  ValueListenableBuilder(
                      valueListenable: store.showSelected,
                      builder: (context, showSelected, _) {
                        return IconButton(
                          onPressed: store.toggleShowSelected,
                          tooltip: showSelected
                              ? 'Mostrar Todos'
                              : 'Mostrar Seleção',
                          icon: Icon(
                            showSelected
                                ? Icons.ballot_rounded
                                : Icons.ballot_outlined,
                          ),
                        );
                      }),
                ],
              ),
              floatingActionButton: OverflowBar(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FloatingActionButton(
                      heroTag: 'hero-1',
                      backgroundColor:
                          colorScheme.primaryContainer.withOpacity(0.85),
                      onPressed: _closeMechanicsPage,
                      tooltip: 'Voltar',
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  if (getIt<CurrentUser>().isAdmin) ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: FloatingActionButton(
                        heroTag: 'hero-2',
                        backgroundColor:
                            colorScheme.primaryContainer.withOpacity(0.85),
                        onPressed: _addMechanic,
                        tooltip: 'Adicionar',
                        child: const Icon(Icons.add),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: FloatingActionButton(
                        heroTag: 'hero-3',
                        backgroundColor:
                            colorScheme.primaryContainer.withOpacity(0.85),
                        onPressed: _removeMechanic,
                        tooltip: 'Remover',
                        child: const Icon(Icons.remove),
                      ),
                    ),
                  ],
                  FloatingActionButton(
                    backgroundColor:
                        colorScheme.primaryContainer.withOpacity(0.85),
                    onPressed: ctrl.deselectAll,
                    tooltip: 'Deselecionar',
                    child: const Icon(Icons.deselect),
                  ),
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: (!store.showSelected.value)
                    ? ShowAllMechs(
                        store: store,
                      )
                    : ShowOnlySelectedMechs(
                        store: store,
                      ),
              ),
            ),
            if (store.isLoading)
              const Positioned.fill(
                child: StateLoadingMessage(),
              ),
            if (store.isError)
              Positioned.fill(
                child: StateErrorMessage(
                  closeDialog: ctrl.closeDialog,
                ),
              ),
          ],
        );
      },
    );
  }
}

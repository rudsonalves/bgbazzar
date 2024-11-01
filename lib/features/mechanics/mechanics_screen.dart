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

import '../../common/singletons/current_user.dart';
import '../../components/others_widgets/state_error_message.dart';
import '../../components/others_widgets/state_loading_message.dart';
import '../../get_it.dart';
import 'mechanics_controller.dart';
import 'mechanics_state.dart';
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

  @override
  void initState() {
    super.initState();

    ctrl.init(widget.selectedPsIds);
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  void _closeMechanicsPage() {
    Navigator.pop(context, ctrl.selectedPsIds);
  }

  Future<void> _addMechanic() async {
    final mech = await MechanicDialog.open(context);
    if (mech != null) ctrl.add(mech);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: ctrl,
      builder: (context, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: ValueListenableBuilder(
                    valueListenable: ctrl.counter,
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
                          mechsNames: ctrl.mechsNames,
                          selectMechByName: ctrl.selectMechByName,
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: ctrl.toogleDescription,
                    tooltip: ctrl.hideDescription
                        ? 'Mostrar Descrição'
                        : 'Ocultar Descrição',
                    icon: Icon(
                      ctrl.hideDescription
                          ? Icons.description_outlined
                          : Icons.insert_drive_file_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: ctrl.toogleShowSelection,
                    tooltip:
                        ctrl.showSelected ? 'Mostrar Todos' : 'Mostrar Seleção',
                    icon: Icon(
                      ctrl.showSelected
                          ? Icons.ballot_rounded
                          : Icons.ballot_outlined,
                    ),
                  ),
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
                  if (getIt<CurrentUser>().isAdmin)
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
                child: (!ctrl.showSelected)
                    ? ShowAllMechs(
                        mechanics: ctrl.mechanics,
                        isSelectedIndex: ctrl.isSelectedIndex,
                        toogleSelectionIndex: ctrl.toogleSelectionIndex,
                        hideDescription: ctrl.hideDescription,
                      )
                    : ShowOnlySelectedMechs(
                        selectedPsIds: ctrl.selectedPsIds,
                        mechanicOfPsId: ctrl.mechanicOfPsId,
                        toogleSelectedInIndex: ctrl.removeSelectionIndex,
                        hideDescription: ctrl.hideDescription,
                      ),
              ),
            ),
            if (ctrl.state is MechanicsStateLoading)
              const Positioned.fill(
                child: StateLoadingMessage(),
              ),
            if (ctrl.state is MechanicsStateError)
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

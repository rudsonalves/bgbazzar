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

import 'package:bgbazzar/components/others_widgets/state_error_message.dart';
import 'package:bgbazzar/components/others_widgets/state_loading_message.dart';
import 'package:bgbazzar/features/mechanics/mechanics_state.dart';
import 'package:flutter/material.dart';

import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import 'mechanics_controller.dart';
import 'widgets/mechanic_dialog.dart';
import 'widgets/show_all_mechs.dart';
import 'widgets/show_selected_mechs.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: ctrl.counter,
            builder: (context, counter, _) {
              return Text('Mecânicas ($counter)');
            }),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ListenableBuilder(
          listenable: Listenable.merge([ctrl.redraw, ctrl.showSelected, ctrl]),
          builder: (context, _) {
            return Stack(
              children: [
                (!ctrl.showSelected.value)
                    ? ShowSelectedMechs(
                        mechanics: ctrl.mechanics,
                        isSelectedIndex: ctrl.isSelectedIndex,
                        toogleSelectionIndex: ctrl.toogleSelectionIndex)
                    : ShowAllMechs(
                        selectedPsIds: ctrl.selectedPsIds,
                        mechanicOfPsId: ctrl.mechanicOfPsId,
                        toogleSelectedInIndex: ctrl.toogleSelectedInIndex,
                      ),
                if (ctrl.state is MechanicsStateLoading)
                  const Positioned.fill(
                    child: StateLoadingMessage(),
                  ),
                if (ctrl.state is MechanicsStateError)
                  Positioned(
                    child: StateErrorMessage(
                      closeDialog: ctrl.closeDialog,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

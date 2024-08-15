// ignore_for_file: public_member_api_docs, sort_constructors_first
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

import '../../components/others_widgets/state_error_message.dart';
import '../../components/others_widgets/state_loading_message.dart';
import '../edit_boardgame/edit_boardgame_screen.dart';
import '../shop/widgets/search/search_dialog.dart';
import 'boardgame_controller.dart';
import 'boardgame_state.dart';

class BoardgameScreen extends StatefulWidget {
  const BoardgameScreen({super.key});

  static const routeName = '/boardgame_screen';

  @override
  State<BoardgameScreen> createState() => _BoardgameScreenState();
}

class _BoardgameScreenState extends State<BoardgameScreen> {
  final ctrl = BoardgameController();

  @override
  void initState() {
    super.initState();
    ctrl.init();
  }

  @override
  void dispose() {
    ctrl.dispose();

    super.dispose();
  }

  void _backPageWithGame() => Navigator.pop(context, ctrl.selectedBGId);

  void _addBoardgame() {
    Navigator.pushNamed(context, EditBoardgamesScreen.routeName);
  }

  Future<void> _openSearchDialog() async {
    String? result = await showSearch<String>(
      context: context,
      delegate: SearchDialog(),
    );

    if (result != null && result.isEmpty) {
      result = null;
    }
    ctrl.changeSearchName(result ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boardgames'),
        centerTitle: true,
        leading: IconButton(
          onPressed: _backPageWithGame,
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          IconButton(
            onPressed: _openSearchDialog,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: ctrl.isAdmin
          ? FloatingActionButton.extended(
              onPressed: _addBoardgame,
              icon: const Icon(Icons.add),
              label: const Text('Boardgame'),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListenableBuilder(
          listenable: ctrl,
          builder: (context, _) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: ctrl.filteredBGs.length,
                  itemBuilder: (context, index) => Card(
                    color: ctrl.isSelected(ctrl.filteredBGs[index])
                        ? colorScheme.tertiaryContainer
                        : null,
                    child: ListTile(
                      title: Text(ctrl.filteredBGs[index].name!),
                      onTap: () => ctrl.selectBGId(ctrl.filteredBGs[index]),
                    ),
                  ),
                ),
                if (ctrl.state is BoardgameStateLoading)
                  const Positioned.fill(
                    child: StateLoadingMessage(),
                  ),
                if (ctrl.state is BoardgameStateError)
                  Positioned.fill(
                    child: StateErrorMessage(
                      closeDialog: ctrl.closeError,
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

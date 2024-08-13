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
import '../boardgames/boardgame_screen.dart';
import 'bg_search_controller.dart';
import 'bg_search_state.dart';
import 'widgets/bg_info_card.dart';
import 'widgets/search_card.dart';

class BggSearchScreen extends StatefulWidget {
  const BggSearchScreen({super.key});

  static const routeName = '/bggsearch';

  @override
  State<BggSearchScreen> createState() => _BggSearchScreenState();
}

class _BggSearchScreenState extends State<BggSearchScreen> {
  final ctrl = BgController();

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  void _startSearch() {
    FocusScope.of(context).nextFocus();
    ctrl.searchBgg();
  }

  void _backPage() => Navigator.pop(context, null);

  void _backPageWithGame() => Navigator.pop(context, ctrl.selectedGame);

  void _addBoardgame() {
    Navigator.pushNamed(context, BoardgamesScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boardgame Info'),
        centerTitle: true,
        leading: IconButton(
          onPressed: _backPageWithGame,
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      floatingActionButton: ctrl.isAdmin
          ? FloatingActionButton.extended(
              onPressed: _addBoardgame,
              icon: const Icon(Icons.add),
              label: const Text('Boardgame'),
            )
          : null,
      body: ListenableBuilder(
          listenable: ctrl,
          builder: (context, _) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: ctrl.bgName,
                          decoration: InputDecoration(
                            hintText: 'Entre com o nome do jogo',
                            suffixIcon: IconButton(
                              onPressed: _startSearch,
                              icon: const Icon(Icons.search),
                            ),
                          ),
                          onSubmitted: (value) => _startSearch(),
                        ),
                        if (ctrl.bggSearchList.isNotEmpty)
                          SearchCard(
                            bgSearchList: ctrl.bggSearchList,
                            getBoardInfo: ctrl.getBoardInfo,
                          ),
                        if (ctrl.selectedGame != null)
                          BGInfoCard(ctrl.selectedGame!),
                        if (ctrl.selectedGame != null)
                          OverflowBar(
                            alignment: MainAxisAlignment.spaceAround,
                            children: [
                              FilledButton.tonalIcon(
                                onPressed: _backPageWithGame,
                                label: const Text('Selecionar'),
                                icon: const Icon(
                                    Icons.check_circle_outline_rounded),
                              ),
                              FilledButton.tonalIcon(
                                onPressed: _backPage,
                                label: const Text('Cancelar'),
                                icon: const Icon(Icons.cancel),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if (ctrl.state is BggSearchStateLoading)
                  const Positioned.fill(
                    child: StateLoadingMessage(),
                  ),
                if (ctrl.state is BggSearchStateError)
                  Positioned.fill(
                    child: StateErrorMessage(
                      closeDialog: ctrl.closeError,
                    ),
                  ),
              ],
            );
          }),
    );
  }
}

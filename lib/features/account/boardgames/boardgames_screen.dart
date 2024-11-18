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

import '/components/widgets/base_dismissible_container.dart';
import '/components/widgets/state_error_message.dart';
import '/components/widgets/state_loading_message.dart';
import '/core/models/bg_name.dart';
import 'edit_boardgame/edit_boardgame_screen.dart';
import '../../shop/widgets/search/search_dialog.dart';
import 'boardgames_controller.dart';
import 'boardgames_store.dart';
import 'widgets/custom_floating_action_bar.dart';
import 'widgets/view_boardgame.dart';

class BoardgamesScreen extends StatefulWidget {
  const BoardgamesScreen({super.key});

  static const routeName = '/boardgame_screen';

  @override
  State<BoardgamesScreen> createState() => _BoardgamesScreenState();
}

class _BoardgamesScreenState extends State<BoardgamesScreen> {
  final ctrl = BoardgamesController();
  final store = BoardgamesStore();

  @override
  void initState() {
    super.initState();
    ctrl.init(store);
  }

  @override
  void dispose() {
    store.dispose();

    super.dispose();
  }

  void _backPageWithGame() => Navigator.pop(context, ctrl.selectedBGId);

  Future<void> _addBoardgame() async {
    await Navigator.pushNamed(context, EditBoardgamesScreen.routeName);
    ctrl.changeSearchName('');
  }

  Future<void> _editBoardgame(BGNameModel editedBg) async {
    final result = await ctrl.getBoardgameSelected(editedBg.id);
    if (result.isFailure) {
      throw Exception(result.error);
    }
    final bg = result.data;
    if (bg != null) {
      if (mounted) {
        Navigator.pushNamed(
          context,
          EditBoardgamesScreen.routeName,
          arguments: bg,
        );
      }
    }
    ctrl.changeSearchName('');
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

  Future<void> _viewBoardgame() async {
    final result = await ctrl.getBoardgameSelected();
    if (result.isFailure) {
      throw Exception(result.error);
    }
    final bg = result.data;
    if (bg == null) return;
    if (mounted) {
      Navigator.pushNamed(context, ViewBoardgame.routeName, arguments: bg);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: CustomFloatingActionBar(
        backPageWithGame: _backPageWithGame,
        addBoardgame: _addBoardgame,
        viewBoardgame: _viewBoardgame,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ValueListenableBuilder(
          valueListenable: store.state,
          builder: (context, state, _) => Stack(
            children: [
              ListView.builder(
                itemCount: ctrl.filteredBGs.length,
                itemBuilder: (context, index) => DismissibleBoardgame(
                  bg: ctrl.filteredBGs[index],
                  selectBGId: ctrl.selectBGId,
                  isSelected: ctrl.isSelected,
                  saveBg: _editBoardgame,
                ),
              ),
              if (store.isLoading)
                const Positioned.fill(
                  child: StateLoadingMessage(),
                ),
              if (store.isError)
                Positioned.fill(
                  child: StateErrorMessage(
                    closeDialog: ctrl.closeError,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DismissibleBoardgame extends StatelessWidget {
  final BGNameModel bg;
  final Function(BGNameModel) selectBGId;
  final Function(BGNameModel) isSelected;
  final Future<void> Function(BGNameModel)? saveBg;
  final Future<bool> Function(BGNameModel)? deleteBg;

  final Color colorLeft;
  final IconData iconLeft;
  final String labelLeft;

  final Color colorRight;
  final IconData iconRight;
  final String labelRight;

  const DismissibleBoardgame({
    super.key,
    required this.bg,
    required this.selectBGId,
    required this.isSelected,
    this.colorLeft = Colors.green,
    this.iconLeft = Icons.edit,
    this.labelLeft = 'Editar',
    this.colorRight = Colors.red,
    this.iconRight = Icons.delete,
    this.labelRight = 'Remover',
    this.saveBg,
    this.deleteBg,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: UniqueKey(),
      background: baseDismissibleContainer(
        context,
        alignment: Alignment.centerLeft,
        color: colorLeft.withOpacity(0.3),
        icon: iconLeft,
        label: labelLeft,
        enable: saveBg != null,
      ),
      secondaryBackground: baseDismissibleContainer(
        context,
        alignment: Alignment.centerRight,
        color: colorRight.withOpacity(0.3),
        icon: iconRight,
        label: labelRight,
        enable: deleteBg != null,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected(bg) ? colorScheme.tertiaryContainer : null,
        ),
        child: ListTile(
          title: Text(bg.name!),
          onTap: () => selectBGId(bg),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          if (saveBg != null) {
            saveBg!(bg);
          }
          return false;
        } else if (direction == DismissDirection.endToStart) {
          if (deleteBg != null) {
            return deleteBg!(bg);
          }
          return false;
        }
        return false;
      },
    );
  }
}

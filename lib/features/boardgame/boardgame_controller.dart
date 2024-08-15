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

import '../../common/models/bg_name.dart';
import '../../common/models/boardgame.dart';
import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import '../../manager/boardgames_manager.dart';
import '../../repository/parse_server/ps_boardgame_repository.dart';
import 'boardgame_state.dart';

class BoardgameController extends ChangeNotifier {
  BoardgameState _state = BoardgameStateInitial();

  final bgName = TextEditingController();
  List<BGNameModel> bggSearchList = [];
  BoardgameModel? selectedGame;

  BoardgameState get state => _state;

  final bgNamesManager = getIt<BoardgamesManager>();
  final user = getIt<CurrentUser>();

  bool get isAdmin => user.isAdmin;

  @override
  void dispose() {
    bgName.dispose();
    super.dispose();
  }

  void _changeState(BoardgameState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> searchBg() async {
    final searchBg = bgName.text.trim();
    if (searchBg.isEmpty) return;

    try {
      _changeState(BoardgameStateLoading());
      bggSearchList = bgNamesManager.searchName(searchBg);
      _changeState(BoardgameStateSuccess());
    } catch (err) {
      _changeState(BoardgameStateError());
    }
  }

  closeError() {
    _changeState(BoardgameStateSuccess());
  }

  Future<void> getBoardInfo(String id) async {
    try {
      _changeState(BoardgameStateLoading());
      selectedGame = await PSBoardgameRepository.getById(id);
      _changeState(BoardgameStateSuccess());
    } catch (err) {
      _changeState(BoardgameStateError());
    }
  }
}

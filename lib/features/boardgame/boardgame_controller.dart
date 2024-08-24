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

import '../../common/abstracts/data_result.dart';
import '../../common/models/bg_name.dart';
import '../../common/models/boardgame.dart';
import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import '../../manager/boardgames_manager.dart';
import 'boardgame_state.dart';

class BoardgameController extends ChangeNotifier {
  BoardgameState _state = BoardgameStateInitial();

  final bgManager = getIt<BoardgamesManager>();
  final user = getIt<CurrentUser>();
  final List<BGNameModel> _filteredBGs = [];
  String _search = '';
  String? _selectedBGId;

  BoardgameState get state => _state;
  bool get isAdmin => user.isAdmin;
  List<BGNameModel> get bgs => bgManager.bgs;
  String get search => _search;
  List<BGNameModel> get filteredBGs => _filteredBGs;
  String? get selectedBGId => _selectedBGId;

  void _changeState(BoardgameState newState) {
    _state = newState;
    notifyListeners();
  }

  void init() {
    _updateSearchFilter('');
  }

  closeError() {
    _changeState(BoardgameStateSuccess());
  }

  Future<void> changeSearchName(String fsearch) async {
    _changeState(BoardgameStateLoading());
    _updateSearchFilter(fsearch);
    await Future.delayed(const Duration(milliseconds: 50));
    _changeState(BoardgameStateSuccess());
  }

  bool isSelected(BGNameModel bg) => bg.bgId == _selectedBGId;

  void _updateSearchFilter(String fsearch) {
    _search = fsearch.trim();
    _filteredBGs.clear();
    _filteredBGs.addAll(bgs
        .where(
          (item) => item.name!.toLowerCase().contains(_search.toLowerCase()),
        )
        .toList());
  }

  Iterable<BGNameModel> suggestionsList(String search) {
    final searchBy = search.toLowerCase().trim();
    if (searchBy.trim().isNotEmpty) {
      final suggestionsBGs = bgs.where(
        (bg) => bg.name!.toLowerCase().contains(searchBy.toLowerCase()),
      );
      return suggestionsBGs;
    }
    return [];
  }

  Future<void> selectBGId(BGNameModel bg) async {
    _changeState(BoardgameStateLoading());
    _selectedBGId = (_selectedBGId == bg.bgId) ? null : bg.bgId;
    _changeState(BoardgameStateSuccess());
  }

  Future<DataResult<BoardgameModel?>> getBoardgameSelected() async {
    if (_selectedBGId == null) {
      return DataResult.failure(const GenericFailure());
    }

    return await bgManager.getBoardgameId(_selectedBGId!);
  }
}

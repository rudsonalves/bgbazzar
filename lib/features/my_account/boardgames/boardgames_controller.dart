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

import '../../../core/abstracts/data_result.dart';
import '../../../core/models/bg_name.dart';
import '../../../core/models/boardgame.dart';
import '../../../core/singletons/current_user.dart';
import '../../../get_it.dart';
import '../../../data_managers/boardgames_manager.dart';
import 'boardgames_store.dart';

class BoardgamesController {
  late final BoardgamesStore store;

  final bgManager = getIt<BoardgamesManager>();
  final user = getIt<CurrentUser>();
  final List<BGNameModel> _filteredBGs = [];
  String _search = '';
  String? _selectedBGId;

  bool get isAdmin => user.isAdmin;
  List<BGNameModel> get bgs => bgManager.localBGList;
  String get search => _search;
  List<BGNameModel> get filteredBGs => _filteredBGs;
  String? get selectedBGId => _selectedBGId;

  void init(BoardgamesStore store) {
    this.store = store;

    _updateSearchFilter('');
  }

  closeError() {
    store.setStateSuccess();
  }

  Future<void> changeSearchName(String fsearch) async {
    store.setStateLoading();
    _updateSearchFilter(fsearch);
    await Future.delayed(const Duration(milliseconds: 50));
    store.setStateSuccess();
  }

  bool isSelected(BGNameModel bg) => bg.id == _selectedBGId;

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

  void selectBGId(BGNameModel bg) {
    store.setStateLoading();
    _selectedBGId = (_selectedBGId == bg.id) ? null : bg.id;
    store.setStateSuccess();
  }

  Future<DataResult<BoardgameModel?>> getBoardgameSelected(
      [String? bgId]) async {
    final id = bgId ?? _selectedBGId;
    if (id == null) {
      return DataResult.failure(const GenericFailure());
    }

    return await bgManager.getBoardgameId(id);
  }
}

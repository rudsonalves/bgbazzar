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

import '../common/models/bg_name.dart';
import '../repository/parse_server/boardgame_repository.dart';

class BgNamesManager {
  final List<BGNameModel> _bgs = [];

  List<BGNameModel> get bgs => _bgs;
  List<String> get bgNames => _bgs.map((bg) => bg.name!).toList();

  Future<void> init() async {
    await getBGNames();
  }

  Future<void> getBGNames() async {
    final names = await BoardgameRepository.getNames();
    _bgs.clear();
    if (names.isNotEmpty) {
      _bgs.addAll(names);
    }
  }

  String? gameId(String gameName) {
    final id = _bgs
        .firstWhere((bg) => bg.name == gameName, orElse: () => BGNameModel())
        .id;
    return id;
  }

  List<BGNameModel> searchName(String name) {
    final result = _bgs.where((bg) => bg.name!.toLowerCase().contains(name));

    return result.toList();
  }
}

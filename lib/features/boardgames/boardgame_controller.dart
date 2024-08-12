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

import '../../manager/bg_names_manager.dart';
import '../../manager/mechanics_manager.dart';
import '../../common/models/boardgame.dart';
import '../../components/custon_field_controllers/numeric_edit_controller.dart';
import '../../get_it.dart';
import '../../repository/parse_server/boardgame_repository.dart';
import 'boardgame_state.dart';

class BoardgameController extends ChangeNotifier {
  BoardgameState _state = BoardgameStateInitial();

  final bgNamesManager = getIt<BgNamesManager>();
  final mechManager = getIt<MechanicsManager>();

  final nameController = TextEditingController();
  final minPlayersController = TextEditingController();
  final maxPlayersController = TextEditingController();
  final minTimeController = TextEditingController();
  final maxTimeController = TextEditingController();
  final ageController = TextEditingController();
  final descriptionController = TextEditingController();
  final weightController = NumericEditController();
  final averageController = NumericEditController();
  final mechsController = TextEditingController();

  BoardgameState get state => _state;
  List<String> get bgNames => bgNamesManager.bgNames;

  void init() {
    initBggRank();
  }

  @override
  void dispose() {
    nameController.dispose();
    minPlayersController.dispose();
    maxPlayersController.dispose();
    minTimeController.dispose();
    maxTimeController.dispose();
    ageController.dispose();
    descriptionController.dispose();
    weightController.dispose();
    averageController.dispose();
    mechsController.dispose();
    super.dispose();
  }

  void _changeState(BoardgameState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> initBggRank() async {
    try {
      _changeState(BoardgameStateLoading());
      await bgNamesManager.init();
      _changeState(BoardgameStateSuccess());
    } catch (err) {
      _changeState(BoardgameStateError());
    }
  }

  Future<void> getBggInfo() async {
    try {
      _changeState(BoardgameStateLoading());
      if (nameController.text.isEmpty) return;
      final id = bgNamesManager.gameId(nameController.text);
      if (id == null) return;
      final bggInfo = await BoardgameRepository.getById(id);
      if (bggInfo != null) loadBoardInfo(bggInfo);
      log(bggInfo.toString());
      _changeState(BoardgameStateSuccess());
    } catch (err) {
      _changeState(BoardgameStateError());
    }
  }

  loadBoardInfo(BoardgameModel bggInfo) {
    minPlayersController.text = bggInfo.minPlayers.toString();
    maxPlayersController.text = bggInfo.maxPlayers.toString();
    minTimeController.text = bggInfo.minTime.toString();
    maxTimeController.text = bggInfo.maxTime.toString();
    ageController.text = bggInfo.minAge.toString();
    descriptionController.text = bggInfo.description ?? '';
    weightController.numericValue = bggInfo.weight ?? 0;
    averageController.numericValue = bggInfo.scoring ?? 0;
    mechsController.text = mechManager.namesFromIdListString(bggInfo.mechanics);
  }

  void closeErroMessage() {
    _changeState(BoardgameStateSuccess());
  }
}

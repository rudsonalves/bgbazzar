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

import '../../common/models/mechanic.dart';
import '../../manager/boardgames_manager.dart';
import '../../manager/mechanics_manager.dart';
import '../../common/models/boardgame.dart';
import '../../components/custon_field_controllers/numeric_edit_controller.dart';
import '../../get_it.dart';
import '../../repository/parse_server/ps_boardgame_repository.dart';
import 'edit_boardgame_state.dart';

class EditBoardgameController extends ChangeNotifier {
  EditBoardgameState _state = EditBoardgameStateInitial();

  final bgManager = getIt<BoardgamesManager>();
  final mechManager = getIt<MechanicsManager>();
  final mechanicsManager = getIt<MechanicsManager>();

  final nameController = TextEditingController();
  final yearController = NumericEditController<int>(initialValue: 2010);
  final imageController = TextEditingController();
  final minPlayersController = NumericEditController<int>();
  final maxPlayersController = NumericEditController<int>();
  final minTimeController = NumericEditController<int>();
  final maxTimeController = NumericEditController<int>();
  final ageController = NumericEditController<int>();
  final designerController = TextEditingController();
  final artistController = TextEditingController();
  final descriptionController = TextEditingController();
  final mechsController = TextEditingController();

  final List<String> _selectedMechPsIds = [];

  BoardgameModel? _editedBg;

  List<MechanicModel> get mechanics => mechanicsManager.mechanics;

  List<String> get selectedMechIds => _selectedMechPsIds;
  List<String> get selectedMachNames => mechanics
      .where((c) => _selectedMechPsIds.contains(c.psId!))
      .map((c) => c.name)
      .toList();

  EditBoardgameState get state => _state;
  List<String> get bgNames => bgManager.bgNames;

  void init(BoardgameModel? bg) {
    if (bg != null) {
      _editedBg = bg;
      nameController.text = bg.name;
      yearController.numericValue = bg.publishYear;
      imageController.text = bg.image;
      minPlayersController.numericValue = bg.minPlayers;
      maxPlayersController.numericValue = bg.maxPlayers;
      minTimeController.numericValue = bg.minTime;
      maxTimeController.numericValue = bg.maxTime;
      ageController.numericValue = bg.minAge;
      designerController.text = bg.designer ?? '';
      artistController.text = bg.artist ?? '';
      descriptionController.text = bg.description ?? '';
      mechsController.text = mechManager.namesFromIdListString(bg.mechsPsIds);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    yearController.dispose();
    imageController.dispose();
    minPlayersController.dispose();
    maxPlayersController.dispose();
    minTimeController.dispose();
    maxTimeController.dispose();
    ageController.dispose();
    designerController.dispose();
    artistController.dispose();
    descriptionController.dispose();
    mechsController.dispose();
    super.dispose();
  }

  void _changeState(EditBoardgameState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getBgInfo() async {
    if (nameController.text.isEmpty) return;
    try {
      _changeState(EditBoardgameStateLoading());
      final id = bgManager.gameId(nameController.text);
      if (id == null) {
        _changeState(EditBoardgameStateSuccess());
        return;
      }
      final bgInfo = await PSBoardgameRepository.getById(id);
      if (bgInfo != null) loadBoardInfo(bgInfo);
      log(bgInfo.toString());
      _changeState(EditBoardgameStateSuccess());
    } catch (err) {
      _changeState(EditBoardgameStateError());
    }
  }

  loadBoardInfo(BoardgameModel bg) {
    yearController.numericValue = bg.publishYear.toInt();
    imageController.text = bg.image;
    minPlayersController.text = bg.minPlayers.toString();
    maxPlayersController.text = bg.maxPlayers.toString();
    minTimeController.text = bg.minTime.toString();
    maxTimeController.text = bg.maxTime.toString();
    ageController.text = bg.minAge.toString();
    designerController.text = bg.designer ?? '';
    artistController.text = bg.designer ?? '';
    descriptionController.text = bg.description ?? '';
    mechsController.text = mechManager.namesFromIdListString(bg.mechsPsIds);
  }

  Future<void> saveBoardgame() async {
    try {
      _changeState(EditBoardgameStateLoading());
      if (_editedBg != null && _editedBg!.bgId != null) {
        _editedBg!.name = nameController.text;
        _editedBg!.image = imageController.text;
        _editedBg!.publishYear = yearController.numericValue;
        _editedBg!.minPlayers = minPlayersController.numericValue;
        _editedBg!.maxPlayers = maxPlayersController.numericValue;
        _editedBg!.minTime = minTimeController.numericValue;
        _editedBg!.maxTime = maxTimeController.numericValue;
        _editedBg!.minAge = ageController.numericValue;
        _editedBg!.mechsPsIds = _selectedMechPsIds;
        _editedBg!.designer = designerController.text;
        _editedBg!.artist = artistController.text;
        _editedBg!.description = descriptionController.text;

        await bgManager.update(_editedBg!);
      } else {
        final bg = BoardgameModel(
          name: nameController.text,
          image: imageController.text,
          publishYear: yearController.numericValue,
          minPlayers: minPlayersController.numericValue,
          maxPlayers: maxPlayersController.numericValue,
          minTime: minTimeController.numericValue,
          maxTime: maxTimeController.numericValue,
          minAge: ageController.numericValue,
          mechsPsIds: _selectedMechPsIds,
          designer: designerController.text,
          artist: artistController.text,
          description: descriptionController.text,
        );

        await bgManager.save(bg);
      }
      _changeState(EditBoardgameStateSuccess());
    } catch (err) {
      _changeState(EditBoardgameStateError());
      log(err.toString());
    }
  }

  void setMechanicsPsIds(List<String> mechPsIds) {
    _selectedMechPsIds.clear();
    _selectedMechPsIds.addAll(mechPsIds);
    mechsController.text = selectedMachNames.join(', ');
  }

  void closeErroMessage() {
    _changeState(EditBoardgameStateSuccess());
  }
}

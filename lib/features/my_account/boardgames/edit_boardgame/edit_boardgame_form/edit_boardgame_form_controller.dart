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

import '../../../../../components/custon_controllers/numeric_edit_controller.dart';
import '../../../../../core/models/boardgame.dart';
import '/get_it.dart';
import '../../../../../data_managers/boardgames_manager.dart';
import '../../../../../data_managers/mechanics_manager.dart';
import '../edit_boardgame_store.dart';

class EditBoardgameFormController {
  final bgManager = getIt<BoardgamesManager>();
  final mechManager = getIt<MechanicsManager>();

  late final EditBoardgameStore store;

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

  final descriptionFocus = FocusNode();

  List<String> get bgNames => bgManager.bgNames;

  void init(EditBoardgameStore store) {
    this.store = store;
    _setBoardgameToForm(store.bg);
  }

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
    descriptionFocus.dispose();
  }

  void _setBoardgameToForm(BoardgameModel bg) {
    nameController.text = bg.name;
    yearController.numericValue = bg.publishYear.toInt();
    imageController.text = bg.image;
    minPlayersController.numericValue = bg.minPlayers;
    maxPlayersController.numericValue = bg.maxPlayers;
    minTimeController.numericValue = bg.minTime;
    maxTimeController.numericValue = bg.maxTime;
    ageController.numericValue = bg.minAge;
    designerController.text = bg.designer ?? '';
    artistController.text = bg.designer ?? '';
    descriptionController.text = bg.description ?? '';
    setMechanicsPsIds(bg.mechsPsIds);
  }

  void setMechanicsPsIds(List<String> mechPsIds) {
    store.setMechsPsIds(mechPsIds);
    _updateMechsController();
  }

  void _updateMechsController() {
    mechsController.text =
        mechManager.namesFromPsIdList(store.bg.mechsPsIds).join(', ');
  }

  void setImage(String? image) {
    if (image != null) {
      imageController.text = image;
      store.setImage(image);
    }
  }
}

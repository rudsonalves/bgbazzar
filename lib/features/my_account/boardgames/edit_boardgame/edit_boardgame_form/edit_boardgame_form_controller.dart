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

  final List<String> _selectedMechPsIds = [];

  List<String> get bgNames => bgManager.bgNames;
  List<String> get selectedMechIds => _selectedMechPsIds;

  void init(EditBoardgameStore store) {
    this.store = store;
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

  // Future<DataResult<void>> getBgInfo() async {
  //   try {
  //     store.setStateLoading();
  //     if (nameController.text.isEmpty) {
  //       throw Exception('name is note defined');
  //     }
  //     final id = bgManager.gameId(nameController.text);
  //     if (id == null) {
  //       throw Exception('boardgame id not found');
  //     }
  //     final result = await PSBoardgameRepository.getById(id);
  //     if (result.isFailure) {
  //       throw Exception(result.error);
  //     }
  //     final bgInfo = result.data;

  //     if (bgInfo != null) loadBoardInfo(bgInfo);
  //     log(bgInfo.toString());
  //     store.setStateSuccess();
  //     return DataResult.success(null);
  //   } catch (err) {
  //     final message = 'EditBoardgameController.getBgInfo: $err';
  //     store.setError(message);
  //     log(message);
  //     return DataResult.failure(GenericFailure(message: message));
  //   }
  // }

  // loadBoardInfo(BoardgameModel bg) {
  //   yearController.numericValue = bg.publishYear.toInt();
  //   imageController.text = bg.image;
  //   minPlayersController.text = bg.minPlayers.toString();
  //   maxPlayersController.text = bg.maxPlayers.toString();
  //   minTimeController.text = bg.minTime.toString();
  //   maxTimeController.text = bg.maxTime.toString();
  //   ageController.text = bg.minAge.toString();
  //   designerController.text = bg.designer ?? '';
  //   artistController.text = bg.designer ?? '';
  //   descriptionController.text = bg.description ?? '';
  //   mechsController.text = mechManager.namesFromIdListString(bg.mechsPsIds);
  // }

  void setMechanicsPsIds(List<String> mechPsIds) {
    _selectedMechPsIds.clear();
    _selectedMechPsIds.addAll(mechPsIds);
    store.setMechsPsIds(_selectedMechPsIds);
    _updateMechsController();
  }

  void _updateMechsController() {
    mechsController.text =
        mechManager.namesFromPsIdList(_selectedMechPsIds).join(', ');
  }

  void setImage(String? image) {
    if (image != null) {
      imageController.text = image;
      store.setImage(image);
    }
  }
}

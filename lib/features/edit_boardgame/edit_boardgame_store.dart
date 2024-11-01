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

import '../../common/models/boardgame.dart';
import '/common/state_store/state_store.dart';

class EditBoardgameStore extends StateStore {
  late final BoardgameModel boardgame;

  bool _isEdited = false;
  bool get isEdited => _isEdited;

  final errorName = ValueNotifier<String?>(null);
  final errorImage = ValueNotifier<String?>(null);
  final errorDescription = ValueNotifier<String?>(null);
  final errorMechsPsIds = ValueNotifier<String?>(null);

  void init(BoardgameModel? boardgame) {
    // Initializes this.boardgame with a copy of the passed boardgame
    // or with a new, clean BoardbameModel.
    this.boardgame =
        boardgame != null ? boardgame.copyWith() : BoardgameModel.clean();
  }

  @override
  void dispose() {
    errorName.dispose();
    errorImage.dispose();
    errorDescription.dispose();
    errorMechsPsIds.dispose();

    super.dispose();
  }

  void setName(String value) {
    boardgame.name = value;
    _validateName();
    _isEdited = true;
  }

  void setImage(String value) {
    boardgame.image = value;
    _validateImage();
    _isEdited = true;
  }

  void setPublishYear(int value) {
    boardgame.publishYear = value;
    _isEdited = true;
  }

  void setMinPlayers(int value) {
    boardgame.minPlayers = value;
    _isEdited = true;
  }

  void setMaxPlayers(int value) {
    boardgame.maxPlayers = value;
    _isEdited = true;
  }

  void setMinTime(int value) {
    boardgame.minTime = value;
    _isEdited = true;
  }

  void setMaxTime(int value) {
    boardgame.maxTime = value;
    _isEdited = true;
  }

  void setMinAge(int value) {
    boardgame.minAge = value;
    _isEdited = true;
  }

  void setDesigner(String value) {
    boardgame.designer = value;
    _isEdited = true;
  }

  void setArtist(String value) {
    boardgame.artist = value;
    _isEdited = true;
  }

  void setDescription(String value) {
    boardgame.description = value;
    _validateDescription();
    _isEdited = true;
  }

  void setMechsPsIds(List<String> value) {
    boardgame.mechsPsIds = List.from(value);
    _validateMechsPsIds();
    _isEdited = true;
  }

  void _validateName() {
    errorName.value =
        boardgame.name.length > 2 ? null : 'Nome deve ter 2 ou mais caracteres';
  }

  void _validateImage() {
    errorImage.value =
        boardgame.image.isNotEmpty ? null : 'Adicione uma imagem padrão.';
  }

  void _validateDescription() {
    errorDescription.value =
        boardgame.description != null && boardgame.description!.isNotEmpty
            ? null
            : 'Adicione uma descrição para o jogo.';
  }

  void _validateMechsPsIds() {
    errorMechsPsIds.value = boardgame.mechsPsIds.isNotEmpty
        ? null
        : 'Selecione algumas mecânicas para o jogo.';
  }

  bool isValid() {
    _validateName();
    _validateImage();
    _validateDescription();
    _validateMechsPsIds();

    return errorName.value == null &&
        errorImage.value == null &&
        errorDescription.value == null &&
        errorMechsPsIds.value == null;
  }
}

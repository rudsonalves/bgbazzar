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

import '/common/models/mechanic.dart';
import '/common/state_store/state_store.dart';

/// A state management store for managing mechanics selection and UI flags.
///
/// Fields:
/// - [selectedsMechs]: List of selected mechanics.
/// - [counter]: Tracks the number of selected mechanics.
/// - [hideDescription]: Controls visibility of descriptions.
/// - [showSelected]: Toggles visibility of selected mechanics.
class MechanicsStore extends StateStore {
  List<MechanicModel> selectedsMechs = [];

  final counter = ValueNotifier<int>(0);
  final hideDescription = ValueNotifier<bool>(false);
  final showSelected = ValueNotifier<bool>(false);

  /// Retrieves the names of all selected mechanics.
  List<String> get mechsNames =>
      selectedsMechs.map((mech) => mech.name).toList();

  /// Retrieves the IDs of all selected mechanics.
  List<String> get selectedMechIds =>
      selectedsMechs.map((mech) => mech.id!).toList();

  /// Disposes all [ValueNotifier]s to free resources.
  @override
  void dispose() {
    counter.dispose();
    hideDescription.dispose();
    showSelected.dispose();

    super.dispose();
  }

  /// Toggles the [hideDescription] flag with loading and success states.
  void toggleHideDescription() {
    setStateLoading();
    hideDescription.value = !hideDescription.value;
    Future.delayed(const Duration(microseconds: 50));
    setStateSuccess();
  }

  /// Toggles the [showSelected] flag with loading and success states.
  void toggleShowSelected() {
    setStateLoading();
    showSelected.value = !showSelected.value;
    Future.delayed(const Duration(microseconds: 50));
    setStateSuccess();
  }

  /// Adds or removes a mechanic from [selectedsMechs].
  /// Updates [counter] with the current count of selected mechanics.
  void setMech(MechanicModel value) {
    if (!isSelectedId(value.id!)) {
      selectedsMechs.add(value);
    } else {
      selectedsMechs.removeWhere((mech) => mech.id == value.id);
    }
    counter.value = selectedsMechs.length;
  }

  /// Clears all selected mechanics and resets [counter].
  void cleanMech() {
    selectedsMechs.clear();
    counter.value = 0;
  }

  /// Checks if a mechanic with the given [id] is selected.
  bool isSelectedId(String id) {
    return selectedMechIds.contains(id);
  }
}

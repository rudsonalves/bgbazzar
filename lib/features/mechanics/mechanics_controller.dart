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

import '../../common/models/mechanic.dart';
import '../../get_it.dart';
import '../../manager/mechanics_manager.dart';

class MechanicsController {
  final mechanicManager = getIt<MechanicsManager>();

  List<MechanicModel> get mechanics => mechanicManager.mechanics;
  MechanicModel Function(int id) get mechanicOfId =>
      mechanicManager.mechanicOfId;

  final List<int> _selectedIds = [];
  final _redraw = ValueNotifier<bool>(false);
  final _showSelected = ValueNotifier<bool>(false);

  List<int> get selectedIds => _selectedIds;
  ValueNotifier<bool> get showSelected => _showSelected;
  ValueNotifier<bool> get redraw => _redraw;

  void init(List<int> ids) {
    _selectedIds.clear();
    _selectedIds.addAll(ids);
  }

  void dispose() {
    _redraw.dispose();
    _showSelected;
  }

  void toogleShowSelection() {
    if (_selectedIds.isEmpty && !_showSelected.value) {
      return;
    } else if (_selectedIds.isEmpty && _showSelected.value) {
      _showSelected.value = false;
    } else {
      _showSelected.value = !_showSelected.value;
    }
    redrawList();
  }

  void redrawList() {
    _redraw.value = !_redraw.value;
  }

  bool isSelectedIndex(int index) {
    return _selectedIds.contains(mechanics[index].id!);
  }

  void toogleSelectionIndex(int index) {
    int id = mechanics[index].id!;
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
    redrawList();
  }

  void toogleSelectedInIndex(int index) {
    _selectedIds.removeAt(index);
    if (_selectedIds.isEmpty && _showSelected.value) {
      _showSelected.value = false;
    } else {
      redrawList();
    }
  }

  void deselectAll() {
    _selectedIds.clear();
    if (_selectedIds.isEmpty && _showSelected.value) {
      _showSelected.value = false;
    } else {
      redrawList();
    }
  }
}

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
import '../../get_it.dart';
import '../../manager/mechanics_manager.dart';

import 'package:flutter/foundation.dart';

import 'mechanics_state.dart';

class MechanicsController extends ChangeNotifier {
  MechanicsState _state = MechanicsStateInitial();

  MechanicsState get state => _state;

  void _changeState(MechanicsState newState) {
    _state = newState;
    notifyListeners();
  }

  final mechanicManager = getIt<MechanicsManager>();

  List<MechanicModel> get mechanics => mechanicManager.mechanics;
  MechanicModel Function(String psId) get mechanicOfPsId =>
      mechanicManager.mechanicOfPsId;

  final List<String> _selectedPsIds = [];
  final _redraw = ValueNotifier<bool>(false);
  final _showSelected = ValueNotifier<bool>(false);
  final _counter = ValueNotifier<int>(0);

  List<String> get selectedPsIds => _selectedPsIds;
  ValueNotifier<bool> get showSelected => _showSelected;
  ValueNotifier<bool> get redraw => _redraw;
  ValueNotifier<int> get counter => _counter;

  void init(List<String> psIds) {
    _selectedPsIds.clear();
    _selectedPsIds.addAll(psIds);
  }

  @override
  void dispose() {
    _redraw.dispose();
    _showSelected.dispose();
    _counter.dispose();

    super.dispose();
  }

  void toogleShowSelection() {
    if (_selectedPsIds.isEmpty && !_showSelected.value) {
      return;
    } else if (_selectedPsIds.isEmpty && _showSelected.value) {
      _showSelected.value = false;
    } else {
      _showSelected.value = !_showSelected.value;
    }
    redrawList();
  }

  void redrawList() {
    _redraw.value = !_redraw.value;
    _counter.value = _selectedPsIds.length;
  }

  bool isSelectedIndex(int index) {
    return _selectedPsIds.contains(mechanics[index].psId!);
  }

  void toogleSelectionIndex(int index) {
    final psId = mechanics[index].psId!;
    if (_selectedPsIds.contains(psId)) {
      _selectedPsIds.remove(psId);
    } else {
      _selectedPsIds.add(psId);
    }
    redrawList();
  }

  void toogleSelectedInIndex(int index) {
    _selectedPsIds.removeAt(index);
    if (_selectedPsIds.isEmpty && _showSelected.value) {
      _showSelected.value = false;
    } else {
      redrawList();
    }
  }

  void deselectAll() {
    _selectedPsIds.clear();
    if (_selectedPsIds.isEmpty && _showSelected.value) {
      _showSelected.value = false;
    } else {
      redrawList();
    }
  }

  Future<void> add(MechanicModel mech) async {
    try {
      _changeState(MechanicsStateLoading());
      await getIt<MechanicsManager>().add(mech);
      _changeState(MechanicsStateSuccess());
    } catch (err) {
      log(err.toString());
      _changeState(MechanicsStateError());
    }
  }

  void closeDialog() {
    _changeState(MechanicsStateSuccess());
  }
}

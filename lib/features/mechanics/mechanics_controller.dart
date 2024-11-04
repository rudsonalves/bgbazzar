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
import 'mechanics_state.dart';

class MechanicsController extends ChangeNotifier {
  MechanicsState _state = MechanicsStateInitial();

  MechanicsState get state => _state;

  void _changeState(MechanicsState newState) {
    _state = newState;
    notifyListeners();
  }

  final _mechanicManager = getIt<MechanicsManager>();

  List<MechanicModel> get mechanics => _mechanicManager.mechanics;
  List<String> get mechsNames => _mechanicManager.mechanicsNames;
  MechanicModel Function(String psId) get mechanicOfPsId =>
      _mechanicManager.mechanicOfPsId;

  final _counter = ValueNotifier<int>(0);
  final List<String> _selectedPsIds = [];
  bool _showSelected = false;
  bool _hideDescription = false;

  ValueNotifier<int> get counter => _counter;
  List<String> get selectedPsIds => _selectedPsIds;
  bool get showSelected => _showSelected;
  bool get hideDescription => _hideDescription;

  void init(List<String> psIds) {
    _selectedPsIds.clear();
    _selectedPsIds.addAll(psIds);
  }

  @override
  void dispose() {
    _counter.dispose();

    super.dispose();
  }

  void toogleShowSelection() {
    if (_selectedPsIds.isEmpty && !_showSelected) {
      return;
    } else if (_selectedPsIds.isEmpty && _showSelected) {
      _showSelected = false;
    } else {
      _showSelected = !_showSelected;
    }
    redrawList();
  }

  void selectMechByName(String name) {
    if (name.isEmpty) return;
    final index = mechanics.indexWhere((mech) => mech.name == name);
    if (index == -1) return;
    toogleSelectionIndex(index);
  }

  Future<void> redrawList() async {
    _changeState(MechanicsStateLoading());
    _counter.value = _selectedPsIds.length;
    await Future.delayed(const Duration(milliseconds: 50));
    _changeState(MechanicsStateSuccess());
  }

  Future<void> toogleDescription() async {
    _changeState(MechanicsStateLoading());
    _hideDescription = !_hideDescription;
    await Future.delayed(const Duration(milliseconds: 50));
    _changeState(MechanicsStateSuccess());
  }

  bool isSelectedIndex(int index) {
    return _selectedPsIds.contains(mechanics[index].id!);
  }

  void toogleSelectionIndex(int index) {
    final psId = mechanics[index].id!;
    if (_selectedPsIds.contains(psId)) {
      _selectedPsIds.remove(psId);
    } else {
      _selectedPsIds.add(psId);
    }
    redrawList();
  }

  void removeSelectionIndex(int index) {
    _selectedPsIds.removeAt(index);
    if (_selectedPsIds.isEmpty) {
      _showSelected = false;
    }
    redrawList();
  }

  void deselectAll() {
    _selectedPsIds.clear();
    if (_selectedPsIds.isEmpty && _showSelected) {
      _showSelected = false;
    } else {
      redrawList();
    }
  }

  Future<void> add(MechanicModel mech) async {
    try {
      _changeState(MechanicsStateLoading());
      await _mechanicManager.add(mech);
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

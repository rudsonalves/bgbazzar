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

import '../../../../core/models/mechanic.dart';
import '../../../../core/state/state_store.dart';

class CheckMechList {
  final MechanicModel mech;
  final bool _checked;

  CheckMechList(this.mech, this._checked);

  bool get isChecked => _checked;
}

class CheckStore extends StateStore {
  final checkList = ValueNotifier<List<CheckMechList>>([]);

  final count = ValueNotifier<int>(0);

  @override
  void dispose() {
    checkList.dispose();
    count.dispose();

    super.dispose();
  }

  void setCheckList(List<CheckMechList> value) {
    checkList.value = value;
  }

  void incrementCount() {
    count.value++;
  }

  void resetCount() {
    count.value = 0;
  }
}

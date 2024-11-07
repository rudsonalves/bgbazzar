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

import '../../core/models/mechanic.dart';
import '../../get_it.dart';
import '../../data_managers/mechanics_manager.dart';
import 'check_store.dart';

class CheckController {
  late final CheckStore store;
  final mechManager = getIt<MechanicsManager>();

  List<MechanicModel> get mechanics => mechManager.mechanics;

  Future<void> init(CheckStore store) async {
    this.store = store;
  }

  Future<void> checkMechanics() async {
    final List<CheckMechList> checkList = [];
    store.resetCount();
    try {
      store.setStateLoading();
      for (final mech in mechanics) {
        final result = await mechManager.get(mech.id!);
        store.incrementCount();
        if (result.isFailure || result.data == null) {
          checkList.add(CheckMechList(mech, false));
          continue;
        }
        final psMech = result.data!;
        checkList.add(CheckMechList(mech, psMech.name == mech.name));
      }
      store.setCheckList(checkList);
      store.setStateSuccess();
    } catch (err) {
      store.setError('Error: $err');
    }
  }
}

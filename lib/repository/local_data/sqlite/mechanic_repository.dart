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

import '../../../core/models/mechanic.dart';
import '../../../store/stores/mechanics_store.dart';
import '../interfaces/i_local_mechanic_repository.dart';

class SqliteMechanicRepository implements ILocalMechanicRepository {
  @override
  Future<List<MechanicModel>> get() async {
    try {
      final result = await MechanicsStore.get();
      if (result.isEmpty) return [];

      final mechanics =
          result.map((item) => MechanicModel.fromMap(item)).toList();
      return mechanics;
    } catch (err) {
      final message = 'MechanicRepository.get: $err';
      log(message);
      throw Exception(message);
      // FIXME: put an empty list retrun hare. If there is no connection the
      //        program chould be closed.
    }
  }

  @override
  Future<MechanicModel?> add(MechanicModel mech) async {
    try {
      final id = await MechanicsStore.add(mech.toMap());
      if (id < 0) throw Exception('return id $id');

      return mech;
    } catch (err) {
      final message = 'MechanicRepository.add: $err';
      log(message);
      return null;
    }
  }

  @override
  Future<int> update(MechanicModel mech) async {
    try {
      final result = await MechanicsStore.update(mech.toMap());
      return result;
    } catch (err) {
      final message = 'MechanicRepository.update: $err';
      log(message);
      throw Exception(message);
    }
  }
}

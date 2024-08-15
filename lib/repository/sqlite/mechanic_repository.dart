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

import '../../common/models/mechanic.dart';
import '../../store/mechanics_store.dart';

/// This class provides methods to interact with the Parse Server
/// to retrieve a list of mechanics.
class MechanicRepository {
  /// Fetches a list of mechanics from the Parse Server.
  ///
  /// Returns a list of `MechanicModel` if the query is successful,
  /// otherwise create an error.
  static Future<List<MechanicModel>> get() async {
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

  static Future<MechanicModel> add(MechanicModel mech) async {
    try {
      final id = await MechanicsStore.add(mech.toMap());
      if (id < 0) throw Exception('return id $id');

      mech.id = id;
      return mech;
    } catch (err) {
      final message = 'MechanicRepository.add: $err';
      log(message);
      throw Exception(message);
    }
  }

  static Future<int> update(MechanicModel mech) async {
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

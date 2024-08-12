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

import 'package:flutter/foundation.dart';

import '../models/ad.dart';
import '../singletons/current_user.dart';
import '../../get_it.dart';
import 'basic_state.dart';

abstract class BasicController extends ChangeNotifier {
  BasicState _state = BasicStateInitial();

  BasicState get state => _state;

  final currentUser = getIt<CurrentUser>();

  final List<AdModel> _ads = [];
  List<AdModel> get ads => _ads;

  void changeState(BasicState newState) {
    _state = newState;
    notifyListeners();
  }

  void init();

  Future<void> getAds();

  Future<void> getMoreAds();

  Future<bool> updateAdStatus(AdModel ad);
}

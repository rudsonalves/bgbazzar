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

import '../../core/models/ad.dart';
import '../../core/singletons/current_user.dart';
import '../../data_managers/ad_manager.dart';
import '../../data_managers/favorites_manager.dart';
import '../../get_it.dart';
import 'favorites_store.dart';

class FavoritesController {
  final FavoritesStore store;

  FavoritesController(this.store) {
    _initialize();
  }

  final currentUser = getIt<CurrentUser>();
  final adManager = getIt<AdManager>();
  final favManager = getIt<FavoritesManager>();

  List<AdModel> get ads => favManager.ads;

  Future<void> _initialize() async {
    try {
      store.setStateLoading();

      favManager.favNotifier.addListener(_refresh);

      await currentUser.init();

      // await Future.delayed(const Duration(seconds: 2));

      store.setStateSuccess();
    } catch (err) {
      final message = 'ShopController._initialize: $err';
      log(message);
      store.setError(message);
    }
  }

  Future<void> getMoreAds() async {}

  Future<void> _refresh() async {
    store.setStateLoading();
    await Future.delayed(const Duration(microseconds: 50));
    store.setStateSuccess();
  }
}

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

import '../../common/app_constants.dart';
import '../../common/models/ad.dart';
import '../../common/models/filter.dart';
import '../../common/models/user.dart';
import '../../common/singletons/app_settings.dart';
import '../../common/singletons/current_user.dart';
import '../../common/singletons/search_filter.dart';
import '../../get_it.dart';
import '../../repository/parse_server/ps_ad_repository.dart';
import '../../repository/parse_server/common/constants.dart';
import 'shop_store.dart';

class ShopController {
  final app = getIt<AppSettings>();
  final currentUser = getIt<CurrentUser>();
  final searchFilter = getIt<SearchFilter>();
  late final ShopStore store;

  final List<AdModel> _ads = [];
  List<AdModel> get ads => _ads;

  int _adsPage = 0;
  bool _getMorePages = true;
  bool get getMorePages => _getMorePages;

  bool get isDark => app.isDark;
  bool get isLogged => currentUser.isLogged;
  UserModel? get user => currentUser.user;
  FilterModel get filter => searchFilter.filter;
  String get searchString => searchFilter.searchString;

  bool get haveSearch => searchFilter.searchString.isNotEmpty;
  bool get haveFilter => searchFilter.haveFilter;

  set filter(FilterModel newFilter) {
    searchFilter.updateFilter(newFilter);
    _getMorePages = true;
  }

  void init(ShopStore store) {
    this.store = store;
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      store.setStateLoading();
      await _getAds();

      await currentUser.init();
      setPageTitle();

      searchFilter.filterNotifier.addListener(getAds);
      searchFilter.searchNotifier.addListener(getAds);
      currentUser.isLogedListernable.addListener(getAds);
      currentUser.isLogedListernable.addListener(setPageTitle);

      store.setStateSuccess();
    } catch (err) {
      final message = 'ShopController._initialize: $err';
      log(message);
      store.setError(message);
    }
  }

  void setPageTitle() {
    store.setPageTitle(
      searchFilter.searchString.isNotEmpty
          ? searchFilter.searchString
          : user == null
              ? appTitle
              : user!.name!,
    );
  }

  void setSearch(String value) {
    searchFilter.searchString = value;
    setPageTitle();
  }

  void cleanSearch() {
    setSearch('');
    filter = FilterModel();
  }

  Future<void> getAds() async {
    try {
      store.setStateLoading();
      await _getAds();
      store.setStateSuccess();
    } catch (err) {
      final message = 'ShopController.getAds: $err';
      log(message);
      store.setError(message);
    }
  }

  Future<void> _getAds() async {
    final result = await PSAdRepository.get(
      filter: filter,
      search: searchFilter.searchString,
    );
    if (result.isFailure) {
      // FIXME: Complete this error handling
      throw Exception('ShopController._getAds error: ${result.error}');
    }
    final newAds = result.data;
    _adsPage = 0;
    ads.clear();
    if (newAds != null && newAds.isNotEmpty) {
      ads.addAll(newAds);
      _getMorePages = maxAdsPerList == newAds.length;
    } else {
      _getMorePages = false;
    }
  }

  Future<void> getMoreAds() async {
    if (!_getMorePages) return;
    _adsPage++;
    try {
      store.setStateLoading();
      await _getMoreAds();
      await Future.delayed(const Duration(microseconds: 100));
      store.setStateSuccess();
    } catch (err) {
      final message = 'ShopController.getMoreAds: $err';
      log(message);
      store.setError(message);
    }
  }

  Future<void> _getMoreAds() async {
    final result = await PSAdRepository.get(
      filter: filter,
      search: searchFilter.searchString,
      page: _adsPage,
    );
    if (result.isFailure) {
      // FIXME: Complete this error handling
      throw Exception('ShopController._getMoreAds error: ${result.error}');
    }
    final newAds = result.data;
    if (newAds != null && newAds.isNotEmpty) {
      ads.addAll(newAds);
      _getMorePages = maxAdsPerList == newAds.length;
    } else {
      _getMorePages = false;
    }
  }

  void closeErroMessage() {
    store.setStateSuccess();
  }
}

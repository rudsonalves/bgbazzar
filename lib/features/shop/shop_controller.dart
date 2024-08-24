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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/app_constants.dart';
import '../../common/basic_controller/basic_controller.dart';
import '../../common/basic_controller/basic_state.dart';
import '../../common/models/ad.dart';
import '../../common/models/filter.dart';
import '../../common/models/user.dart';
import '../../common/singletons/app_settings.dart';
import '../../common/singletons/search_filter.dart';
import '../../get_it.dart';
import '../../repository/parse_server/ps_ad_repository.dart';
import '../../repository/parse_server/common/constants.dart';

class ShopController extends BasicController {
  final app = getIt<AppSettings>();
  final searchFilter = getIt<SearchFilter>();

  final ValueNotifier<String> _pageTitle = ValueNotifier<String>(appTitle);
  int _adsPage = 0;
  bool _getMorePages = true;
  bool get getMorePages => _getMorePages;

  bool get isDark => app.isDark;
  bool get isLogged => currentUser.isLogged;
  UserModel? get user => currentUser.user;
  FilterModel get filter => searchFilter.filter;
  String get searchString => searchFilter.searchString;

  ValueNotifier<String> get pageTitle => _pageTitle;
  ValueNotifier<bool> get filterNotifier => searchFilter.filterNotifier;
  ValueNotifier<String> get searchNotifier => searchFilter.searchNotifier;

  bool get haveSearch => searchFilter.searchString.isNotEmpty;
  bool get haveFilter => searchFilter.haveFilter;

  set filter(FilterModel newFilter) {
    searchFilter.updateFilter(newFilter);
    _getMorePages = true;
  }

  @override
  Future<void> init() async {
    try {
      changeState(BasicStateLoading());
      await _getAds();

      await currentUser.init();
      setPageTitle();

      searchFilter.filterNotifier.addListener(getAds);
      searchFilter.searchNotifier.addListener(getAds);
      currentUser.isLogedListernable.addListener(getAds);
      currentUser.isLogedListernable.addListener(setPageTitle);

      changeState(BasicStateSuccess());
    } catch (err) {
      changeState(BasicStateError());
    }
  }

  @override
  void dispose() {
    _pageTitle.dispose();

    super.dispose();
  }

  void setPageTitle() {
    _pageTitle.value = searchFilter.searchString.isNotEmpty
        ? searchFilter.searchString
        : user == null
            ? appTitle
            : user!.name!;
  }

  void setSearch(String value) {
    searchFilter.searchString = value;
    setPageTitle();
  }

  void cleanSearch() {
    setSearch('');
    filter = FilterModel();
  }

  @override
  Future<void> getAds() async {
    try {
      changeState(BasicStateLoading());
      await _getAds();
      changeState(BasicStateSuccess());
    } catch (err) {
      log(err.toString());
      changeState(BasicStateError());
    }
  }

  Future<void> _getAds() async {
    final result = await PSAdRepository.get(
      filter: filter,
      search: searchFilter.searchString,
    );
    if (result.isFailure) {
      throw Exception(result.error);
    }
    final newAds = result.data!;
    _adsPage = 0;
    ads.clear();
    if (newAds.isNotEmpty) {
      ads.addAll(newAds);
      _getMorePages = maxAdsPerList == newAds.length;
    } else {
      _getMorePages = false;
    }
  }

  @override
  Future<void> getMoreAds() async {
    if (!_getMorePages) return;
    _adsPage++;
    try {
      changeState(BasicStateLoading());
      await _getMoreAds();
      await Future.delayed(const Duration(microseconds: 100));
      changeState(BasicStateSuccess());
    } catch (err) {
      log(err.toString());
      changeState(BasicStateError());
    }
  }

  Future<void> _getMoreAds() async {
    final result = await PSAdRepository.get(
      filter: filter,
      search: searchFilter.searchString,
      page: _adsPage,
    );
    if (result.isFailure) {
      throw Exception(result.error);
    }
    final newAds = result.data!;
    if (newAds.isNotEmpty) {
      ads.addAll(newAds);
      _getMorePages = maxAdsPerList == newAds.length;
    } else {
      _getMorePages = false;
    }
  }

  @override
  Future<bool> updateAdStatus(AdModel ad) {
    throw UnimplementedError();
  }

  void closeErroMessage() {
    changeState(BasicStateSuccess());
  }
}

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

import '/core/models/ad.dart';
import '/core/models/filter.dart';
import '/core/singletons/current_user.dart';
import '/get_it.dart';
import '/repository/data/interfaces/i_ad_repository.dart';
import '/repository/data/parse_server/common/constants.dart';
import 'my_ads_store.dart';

class MyAdsController {
  late final MyAdsStore store;

  final adRepository = getIt<IAdRepository>();

  final currentUser = getIt<CurrentUser>().user!;

  AdStatus _productStatus = AdStatus.active;
  AdStatus get productStatus => _productStatus;

  int _adsDataBasePage = 0;

  final List<AdModel> _ads = [];
  List<AdModel> get ads => _ads;

  bool _getMorePages = true;
  bool get getMorePages => _getMorePages;

  void init(MyAdsStore store) {
    this.store = store;

    setProductStatus(AdStatus.active);
  }

  Future<void> getAds() async {
    try {
      store.setStateLoading();
      await _getAds();
      store.setStateSuccess();
    } catch (err) {
      final message = err.toString();
      log(message);
      store.setError(message);
    }
  }

  Future<void> _getAds() async {
    final result = await adRepository.getMyAds(
      currentUser,
      _productStatus.name,
    );
    if (result.isFailure) {
      // FIXME: Complete this error handling
      throw Exception('MyAdsController.getAds error: ${result.error}');
    }
    final newAds = result.data;
    _adsDataBasePage = 0;
    ads.clear();
    if (newAds != null && newAds.isNotEmpty) {
      ads.addAll(newAds);
      _getMorePages = maxAdsPerList == newAds.length;
    } else {
      _getMorePages = false;
    }
  }

  void setProductStatus(AdStatus newStatus) {
    _productStatus = newStatus;
    getAds();
  }

  Future<void> getMoreAds() async {
    if (!_getMorePages) return;
    try {
      store.setStateLoading();
      await _getMoreAds();
      store.setStateSuccess();
    } catch (err) {
      final message = err.toString();
      log(message);
      store.setError(message);
    }
  }

  Future<void> _getMoreAds() async {
    _adsDataBasePage++;
    final result = await adRepository.get(
      filter: FilterModel(),
      search: '',
      page: _adsDataBasePage,
    );
    if (result.isFailure) {
      // FIXME: Complete this error handling
      throw Exception('MyAdsController._getMoreAds error: ${result.error}');
    }
    final newAds = result.data;
    if (newAds != null && newAds.isNotEmpty) {
      ads.addAll(newAds);
      _getMorePages = maxAdsPerList == newAds.length;
    } else {
      _getMorePages = false;
    }
  }

  Future<bool> updateAdStatus(AdModel ad) async {
    int currentPage = _adsDataBasePage;
    try {
      store.setStateLoading();
      final result = await adRepository.updateStatus(ad);
      if (result.isFailure) {
        throw Exception(result.error);
      }
      await _getAds();
      while (currentPage > 0) {
        await _getMoreAds();
        currentPage--;
      }
      store.setStateSuccess();
      return true;
    } catch (err) {
      final message = 'MyAdsController.updateAdStatus error: $err';
      log(message);
      store.setError(message);
      return false;
    }
  }

  void updateAd(AdModel ad) {
    getAds();
  }

  Future<void> deleteAd(AdModel ad) async {
    try {
      store.setStateLoading();
      ad.status = AdStatus.deleted;
      await adRepository.updateStatus(ad);
      await _getAds();
      store.setStateSuccess();
    } catch (err) {
      final message = 'MyAdsController.deleteAd error: $err';
      log(message);
      store.setError(message);
    }
  }

  void closeErroMessage() {
    store.setStateSuccess();
  }
}

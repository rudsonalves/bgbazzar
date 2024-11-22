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

import '../core/abstracts/data_result.dart';
import '../core/models/ad.dart';
import '../core/models/filter.dart';
import '../core/singletons/search_filter.dart';
import '../get_it.dart';
import '../repository/data/interfaces/i_ad_repository.dart';

class AdManager {
  final adRepository = getIt<IAdRepository>();
  final searchFilter = getIt<SearchFilter>();

  static const maxAdsPerList = 20;

  final List<AdModel> _ads = [];
  List<AdModel> get ads => _ads;

  FilterModel get filter => searchFilter.filter;

  Future<bool> getAds() async {
    bool getMorePages = false;

    final result = await adRepository.get(
      filter: filter,
      search: searchFilter.searchString,
    );
    if (result.isFailure) {
      // FIXME: Complete this error handling
      throw Exception('AdManager._getAds error: ${result.error}');
    }
    final newAds = result.data;
    ads.clear();
    if (newAds != null && newAds.isNotEmpty) {
      ads.addAll(newAds);
      getMorePages = maxAdsPerList == newAds.length;
    } else {
      getMorePages = false;
    }

    return getMorePages;
  }

  Future<bool> getMoreAds(int page) async {
    bool getMorePages = false;

    final result = await adRepository.get(
      filter: filter,
      search: searchFilter.searchString,
      page: page,
    );
    if (result.isFailure) {
      // FIXME: Complete this error handling
      throw Exception('AdManager._getMoreAds error: ${result.error}');
    }
    final newAds = result.data;
    if (newAds != null && newAds.isNotEmpty) {
      ads.addAll(newAds);
      getMorePages = maxAdsPerList == newAds.length;
    } else {
      getMorePages = false;
    }

    return getMorePages;
  }

  Future<DataResult<AdModel>> getAdById(String adId) async {
    try {
      final ad = _ads.firstWhere((ad) => ad.id == adId);
      return DataResult.success(ad);
    } catch (err) {
      final result = await adRepository.getById(adId);
      return result;
    }
  }
}

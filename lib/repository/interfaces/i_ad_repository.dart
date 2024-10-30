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

import '../../common/abstracts/data_result.dart';
import '../../common/models/ad.dart';
import '../../common/models/filter.dart';
import '../../common/models/user.dart';

class AdRepositoryException implements Exception {
  final String message;
  AdRepositoryException(this.message);

  @override
  String toString() => 'UserRepositoryException: $message';
}

abstract class IAdRepository {
  Future<DataResult<void>> moveAdsAddressTo(
      List<String> adsIdList, String moveToId);
  Future<DataResult<List<String>>> adsInAddress(String addressId);
  Future<DataResult<bool>> updateStatus(AdModel ad);
  Future<DataResult<List<AdModel>?>> getMyAds(UserModel usr, int status);
  Future<DataResult<List<AdModel>?>> get(
      {required FilterModel filter, required String search, int page = 0});
  Future<DataResult<AdModel?>> save(AdModel ad);
  Future<DataResult<AdModel?>> update(AdModel ad);
  Future<DataResult<void>> delete(String ad);
}

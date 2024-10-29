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

import '../../common/models/ad.dart';
import '../../common/state_store/state_store.dart';

class EditAdStore extends StateStore {
  late AdModel ad;
  final List<String> images = [];

  void startAd(AdModel? ad) {
    this.ad = ad ??
        AdModel(
          images: [],
          title: '',
          description: '',
          mechanicsPSIds: [],
          price: 0,
        );

    images.addAll(this.ad.images);
  }

  void refreshAdData(AdModel ad) {
    this.ad = ad;
  }

  void refreshAdImages(List<String> images) {
    this.images.clear();
    this.images.addAll(images);
  }

  AdModel? getAd() {
    return ad.copyWith(images: images);
  }
}

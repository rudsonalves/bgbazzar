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

import 'package:flutter/material.dart';

import '/core/state/state_store.dart';
import '../../core/config/app_info.dart';
import '../../core/singletons/search_filter.dart';
import '../../get_it.dart';

class ShopStore extends StateStore {
  final searchFilter = getIt<SearchFilter>();

  final ValueNotifier<String> pageTitle = ValueNotifier<String>(AppInfo.name);

  ValueNotifier<bool> get filterNotifier => searchFilter.filterNotifier;

  ValueNotifier<String> get searchNotifier => searchFilter.searchNotifier;

  void setPageTitle(String value) {
    pageTitle.value = value;
  }

  @override
  void dispose() {
    pageTitle.dispose();
    searchFilter.dispose();

    super.dispose();
  }
}

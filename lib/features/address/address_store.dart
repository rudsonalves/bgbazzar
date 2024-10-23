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

import '../../common/others/enums.dart';

class AddressStore {
  final state = ValueNotifier<PageState>(PageState.initial);

  String? errorMessage;

  final selectedAddressName = ValueNotifier<String>('');

  void setState(PageState state) {
    this.state.value = state;
  }

  bool get isInitial => state.value == PageState.initial;
  bool get isLoading => state.value == PageState.loading;
  bool get isSuccess => state.value == PageState.success;
  bool get isError => state.value == PageState.error;

  setError(String message) {
    errorMessage = message;
    setState(PageState.error);
  }

  void seSelectedAddressName(String addressName) {
    selectedAddressName.value = addressName;
  }

  void dispose() {
    state.dispose();
    selectedAddressName.dispose();
  }
}

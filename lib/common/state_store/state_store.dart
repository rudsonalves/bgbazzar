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

enum PageState { initial, loading, success, error }

class StateStore {
  final state = ValueNotifier<PageState>(PageState.initial);

  String? errorMessage;

  bool get isInitial => state.value == PageState.initial;
  bool get isLoading => state.value == PageState.loading;
  bool get isSuccess => state.value == PageState.success;
  bool get isError => state.value == PageState.error;

  void setStateInitial() => state.value = PageState.initial;
  void setStateLoading() => state.value = PageState.loading;
  void setStateSuccess() => state.value = PageState.success;
  void setStateError() => state.value = PageState.error;

  setError(String message) {
    errorMessage = message;
    setStateError();
  }

  void dispose() {
    state.dispose();
  }
}

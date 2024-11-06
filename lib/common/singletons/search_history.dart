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

import '../../get_it.dart';
import '../../repository/share_preferences/i_app_preferences_repository.dart';

const historyMaxLength = 20;

class SearchHistory {
  final List<String> _history = [];
  final search = SearchController();
  final prefs = getIt<IAppPreferencesRepository>();

  bool _started = false;

  List<String> get history => _history;

  void init() {
    if (_started) return;
    _started = true;

    getHistory();
  }

  void getHistory() {
    _history.clear();
    _history.addAll(prefs.history);
  }

  Future<void> saveHistory(String? value) async {
    // Add new search string
    if (value != null && value.isNotEmpty && value.length >= 3) {
      final searchValue = value.toLowerCase();
      if (!_history.contains(searchValue)) {
        _history.add(searchValue);
      }
    }

    // limited history length
    if (_history.length > historyMaxLength) {
      final length = history.length;
      _history.removeRange(0, length - historyMaxLength);
    }

    // save history
    await prefs.setHistory(_history);
  }

  Iterable<String> searchInHistory(String value) {
    if (value.isEmpty) return _history;
    final searchValue = value.toLowerCase();
    return _history.where((item) => item.contains(searchValue));
  }
}

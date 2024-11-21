// ignore_for_file: public_member_api_docs, sort_constructors_first
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

import 'package:flutter/material.dart';

import '../core/models/bag_item.dart';

class BagManager {
  final items = <BagItemModel>[];

  final itemsCount = ValueNotifier<int>(0);
  final refreshList = ValueNotifier<bool>(false);

  final List<String> _sellerIds = [];

  List<String> get sellers => _sellerIds;

  List<String> get itemsIds => items.map((item) => item.adItem.id!).toList();

  void dispose() {
    itemsCount.dispose();
  }

  /// Return a list os items from a advertiser id `advertiserId` to the
  /// MercadoPago Brick
  Map<String, int> getParameters(String advertiserId) {
    final adItems = items.where((item) => item.adItem.id == advertiserId);

    final Map<String, int> parameters = {
      for (final item in adItems) item.adItem.id!: item.quantity,
    };

    return parameters;
  }

  Future<void> addItem(BagItemModel newItem) async {
    final index = _indexThatHasId(newItem.adItem.id!);
    if (index != -1) {
      increaseQt(newItem.adId);
    } else {
      items.add(newItem);
      _updateCountValue();
      _checkSellers();
    }
    // FIXME: write in database...
  }

  Future<void> increaseQt(String adId) async {
    final index = _indexThatHasId(adId);
    if (index != -1) {
      // Add new item
      items[index].increaseQt();
      _updateCountValue();
      // FIXME: write in database...
    }
  }

  Future<void> decreaseQt(String adId) async {
    final index = _indexThatHasId(adId);
    if (index != -1) {
      items[index].decreaseQt();
      // Remove item
      if (items[index].quantity == 0) {
        items.removeAt(index);
        refreshList.value = !refreshList.value;
        _checkSellers();
      }
      _updateCountValue();
      // FIXME: write in database...
    }
  }

  void _updateCountValue() {
    itemsCount.value =
        items.fold<int>(0, (previus, item) => previus + item.quantity);
    log(itemsCount.value.toString());
  }

  int _indexThatHasId(String id) {
    return items.indexWhere((item) => item.adItem.id == id);
  }

  double total() {
    double sum = 0.0;
    for (final item in items) {
      sum += item.unitPrice * item.quantity;
    }
    return sum;
  }

  void _checkSellers() {
    _sellerIds.clear();
    for (final item in items) {
      if (!_sellerIds.contains(item.adItem.ownerId!)) {
        _sellerIds.add(item.adItem.ownerId!);
      }
    }
  }
}

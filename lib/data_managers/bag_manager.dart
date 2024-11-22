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
  final _items = <BagItemModel>[];

  final itemsCount = ValueNotifier<int>(0);
  final refreshList = ValueNotifier<bool>(false);

  // bags contain the map of purchases made, separated by sellers Id and their
  // selected ad Id
  final Map<String, Set<BagItemModel>> _bagBySeller = {};

  Map<String, Set<BagItemModel>> get bagBySeller => _bagBySeller;
  Set<String> get sellers => _bagBySeller.keys.toSet();

  List<String> get itemsIds => _items.map((item) => item.adItem.id!).toList();

  void dispose() {
    itemsCount.dispose();
  }

  /// Return a list os items from a advertiser id `advertiserId` to the
  /// MercadoPago Brick
  Map<String, int> getParameters(String advertiserId) {
    final adItems = _items.where((item) => item.adItem.id == advertiserId);

    final Map<String, int> parameters = {
      for (final item in adItems) item.adItem.id!: item.quantity,
    };

    return parameters;
  }

  Future<void> addItem(BagItemModel newItem, [int quantity = 1]) async {
    final itemId = newItem.adItem.id!;
    final adId = newItem.adId;
    final index = _indexThatHasId(itemId);
    if (index != -1) {
      increaseQt(adId);
    } else {
      _items.add(newItem);
      _updateCountValue();
      _checkSellers();
    }
    // FIXME: write in database...
  }

  Future<void> increaseQt(String adId) async {
    final index = _indexThatHasId(adId);
    if (index != -1) {
      // Add new item
      _items[index].increaseQt();
      _updateCountValue();
      // FIXME: write in database...
    }
  }

  Future<void> decreaseQt(String adId) async {
    final index = _indexThatHasId(adId);
    if (index != -1) {
      _items[index].decreaseQt();
      // Remove item
      if (_items[index].quantity == 0) {
        _items.removeAt(index);
        refreshList.value = !refreshList.value;
        _checkSellers();
      }
      _updateCountValue();
      // FIXME: write in database...
    }
  }

  void _updateCountValue() {
    itemsCount.value =
        _items.fold<int>(0, (previus, item) => previus + item.quantity);
    log(itemsCount.value.toString());
  }

  int _indexThatHasId(String id) {
    return _items.indexWhere((item) => item.adItem.id == id);
  }

  double total(String sellerId) {
    double sum = 0.0;
    for (final item in _bagBySeller[sellerId]!) {
      sum += item.unitPrice * item.quantity;
    }
    return sum;
  }

  void _checkSellers() {
    _bagBySeller.clear();
    for (final item in _items) {
      final seller = item.adItem.ownerId!;

      _bagBySeller.putIfAbsent(seller, () => <BagItemModel>{}).add(item);
    }
  }

  String? sellerName(String sellerId) {
    try {
      final item = _items.firstWhere((i) => i.adItem.ownerId == sellerId);
      return item.adItem.ownerName;
    } catch (err) {
      log('sellerName return error: $err');
      return null;
    }
  }
}

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

import '/core/models/bag_item.dart';
import '/get_it.dart';
import '/repository/local_data/interfaces/i_local_bag_item_repository.dart';

class BagManager {
  final bagRepository = getIt<ILocalBagItemRepository>();

  final _items = <BagItemModel>[];

  final itemsCount = ValueNotifier<int>(0);
  final refreshList = ValueNotifier<bool>(false);

  bool isLoged = false;

  // bags contain the map of purchases made, separated by sellers Id and their
  // selected ad Id
  final Map<String, Set<BagItemModel>> _bagBySeller = {};

  Map<String, Set<BagItemModel>> get bagBySeller => _bagBySeller;
  Set<String> get sellers => _bagBySeller.keys.toSet();

  List<String> get itemsIds => _items.map((item) => item.adId).toList();

  void dispose() {
    itemsCount.dispose();
  }

  Future<void> initialize(bool isLoged) async {
    await bagRepository.initialize();

    this.isLoged = isLoged;

    if (_items.isEmpty) {
      final result = await bagRepository.getAll();
      if (result.isFailure || result.data!.isEmpty) {
        await _clearInLogout();
      } else {
        _items.addAll(result.data!);
      }

      _updateCountValue();
      _checkSellers();
    } else {
      await _clearInLogout();
      for (final item in _items) {
        await bagRepository.add(item);
      }
    }
  }

  Future<void> _clearInLogout() async {
    bagRepository.cleanDatabase();
  }

  /// Return a list os items from a advertiser id `advertiserId` to the
  /// MercadoPago Brick
  Map<String, int> getParameters(String advertiserId) {
    final adItems = _items.where((item) => item.adId == advertiserId);

    final Map<String, int> parameters = {
      for (final item in adItems) item.adId: item.quantity,
    };

    return parameters;
  }

  Future<void> addItem(BagItemModel newItem, [int quantity = 1]) async {
    final adId = newItem.adId;
    final index = _indexThatHasId(adId);
    if (index != -1) {
      increaseQt(adId);
      await bagRepository.add(newItem);
    } else {
      _items.add(newItem);
      _updateCountValue();
      _checkSellers();
      await bagRepository.update(newItem);
    }
  }

  Future<void> increaseQt(String adId) async {
    final index = _indexThatHasId(adId);
    if (index != -1) {
      // Increase quantity in item
      final bagItem = _items[index];
      bagItem.increaseQt();
      _updateCountValue();
      await bagRepository.update(bagItem);
    }
  }

  Future<void> decreaseQt(String adId) async {
    final index = _indexThatHasId(adId);
    if (index != -1) {
      final bagItem = _items[index];
      bagItem.decreaseQt();
      // Remove item
      if (bagItem.quantity == 0) {
        _items.removeAt(index);
        refreshList.value = !refreshList.value;
        _checkSellers();
        await bagRepository.delete(bagItem.id!);
      } else {
        await bagRepository.update(bagItem);
      }
      _updateCountValue();
    }
  }

  void _updateCountValue() {
    itemsCount.value =
        _items.fold<int>(0, (previus, item) => previus + item.quantity);
    log(itemsCount.value.toString());
  }

  int _indexThatHasId(String id) {
    return _items.indexWhere((item) => item.adId == id);
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
      final seller = item.ownerId;

      _bagBySeller.putIfAbsent(seller, () => <BagItemModel>{}).add(item);
    }
  }

  String? sellerName(String sellerId) {
    try {
      final item = _items.firstWhere((i) => i.ownerId == sellerId);
      return item.ad!.ownerName;
    } catch (err) {
      log('sellerName return error: $err');
      return null;
    }
  }
}

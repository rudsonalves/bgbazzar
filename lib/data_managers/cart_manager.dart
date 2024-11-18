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

import '../core/models/cart_item.dart';

class CartManager {
  final items = <CartItemModel>[];

  List<String> get itemsIds => items.map((item) => item.adItem.id!).toList();

  Map<String, int> getParameters(String advertiserId) {
    final advertiserItems =
        items.where((item) => item.advertiserId == advertiserId);

    final Map<String, int> parameters = {
      for (final item in advertiserItems) item.adItem.id!: item.quantity,
    };

    return parameters;
  }

  Future<void> addItem(CartItemModel item) async {
    try {
      final select = items.firstWhere((i) => item.adItem.id! == i.adItem.id);
      select.increaseQt();
    } catch (e) {
      items.add(item);
    }
    // FIXME: write in database...
  }

  Future<void> increaseQt(CartItemModel item) async {
    final index = _indexThatHasId(item.adItem.id!);
    if (index != -1) {
      items[index].increaseQt();
      // FIXME: write in database...
    }
  }

  Future<void> decreaseQt(CartItemModel item) async {
    final index = _indexThatHasId(item.adItem.id!);
    if (index != -1) {
      items[index].decreaseQt();
      // FIXME: write in database...
    }
  }

  int _indexThatHasId(String id) {
    return items.indexWhere((item) => item.adItem.id == id);
  }
}

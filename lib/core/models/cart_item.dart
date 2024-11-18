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

import 'dart:convert';

import 'ad.dart';

class CartItemModel {
  int? id;
  String advertiserId;
  String advertiserName;
  AdModel adItem;
  int _quantity;

  CartItemModel({
    this.id,
    required this.advertiserId,
    required this.advertiserName,
    required this.adItem,
    int quantity = 1,
  }) : _quantity = quantity;

  int get quantity => _quantity;

  void increaseQt() {
    if (adItem.quantity > _quantity) {
      _quantity++;
    }
  }

  void decreaseQt() {
    if (_quantity == 1) return;
    _quantity--;
  }

  Map<String, dynamic> toMap() {
    if (id != null) {
      return <String, dynamic>{
        'id': id,
        'advertiserId': advertiserId,
        'advertiserName': advertiserName,
        'adItem': jsonEncode(adItem.toJson()),
        'quantity': _quantity,
      };
    }
    return <String, dynamic>{
      'advertiserId': advertiserId,
      'advertiserName': advertiserName,
      'adItem': jsonEncode(adItem.toJson()),
      'quantity': _quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int?,
      advertiserId: map['advertiserId'] as String,
      advertiserName: map['advertiserName'] as String,
      adItem: AdModel.fromJson(jsonDecode(map['adItem'] as String)),
      quantity: map['quantity'] as int,
    );
  }
}

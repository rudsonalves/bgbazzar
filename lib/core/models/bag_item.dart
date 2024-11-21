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

class BagItemModel {
  int? id;
  AdModel adItem;
  String title;
  String description;
  int _quantity;
  double unitPrice;

  BagItemModel({
    this.id,
    required this.adItem,
    required this.title,
    required this.description,
    int quantity = 1,
    required this.unitPrice,
  }) : _quantity = quantity;

  int get quantity => _quantity;
  String get adId => adItem.id!;

  void increaseQt() {
    if (_quantity < adItem.quantity) {
      _quantity++;
    }
  }

  void decreaseQt() {
    if (_quantity > 0) {
      _quantity--;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'adItem': adItem.id!,
      'title': title,
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory BagItemModel.fromMap(Map<String, dynamic> map) {
    return BagItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      adItem: map['adItem'] as AdModel, // Vai dar problema aqui!!!
      title: map['title'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
      unitPrice: map['unitPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory BagItemModel.fromJson(String source) =>
      BagItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  BagItemModel copyWith({
    int? id,
    AdModel? adItem,
    String? title,
    String? description,
    int? quantity,
    double? unitPrice,
  }) {
    return BagItemModel(
      id: id ?? this.id,
      adItem: adItem ?? this.adItem,
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  String toString() {
    return 'SaleItemModel(id: $id,'
        ' adItem: ${adItem.id},'
        ' title: $title,'
        ' description: $description,'
        ' quantity: $quantity,'
        ' unitPrice: $unitPrice)';
  }
}

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

import 'ad.dart';

class BagItemModel {
  int? id;
  AdModel? _ad;
  String _adId;
  String _ownerId;
  String _ownerName;
  String title;
  String description;
  int _quantity;
  double _unitPrice;

  BagItemModel({
    this.id,
    AdModel? ad,
    String? adId,
    String? ownerId,
    String? ownerName,
    required this.title,
    required this.description,
    int? quantity = 1,
    double? unitPrice,
  })  : _ad = ad,
        _quantity = quantity ?? ad!.quantity,
        _adId = adId ?? ad!.id!,
        _ownerId = ownerId ?? ad!.ownerId!,
        _ownerName = ownerName ?? ad!.ownerName!,
        _unitPrice = unitPrice ?? ad!.price;

  AdModel? get ad => _ad;
  String get adId => _adId;
  String get ownerId => _ownerId;
  String get ownerName => _ownerName;
  int get quantity => _quantity;
  double get unitPrice => _unitPrice;

  void setAd(AdModel newAd) {
    _ad = newAd;
    _adId = newAd.id!;
    _ownerId = newAd.ownerId!;
    _ownerName = newAd.ownerName!;
    _unitPrice = newAd.price;
  }

  void increaseQt() {
    if (_quantity < _ad!.quantity) {
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
      'adId': adId,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'title': title,
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory BagItemModel.fromMap(Map<String, dynamic> map) {
    return BagItemModel(
      id: map['id'] as int?,
      // ad: map['adItem'] as AdModel,
      adId: map['adId'] as String,
      ownerId: map['ownerId'] as String,
      ownerName: map['ownerName'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
      unitPrice: map['unitPrice'] as double,
    );
  }

  BagItemModel copyWith({
    int? id,
    AdModel? ad,
    String? adId,
    String? ownerId,
    String? ownerName,
    String? title,
    String? description,
    int? quantity,
    double? unitPrice,
  }) {
    return BagItemModel(
      id: id ?? this.id,
      ad: ad ?? this.ad,
      adId: adId ?? this.adId,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  String toString() {
    return 'BagItemModel(id: $id,'
        ' ad: $ad,'
        ' adId: $_adId,'
        ' ownerId: $_ownerId,'
        ' ownerName: $_ownerName,'
        ' title: $title,'
        ' description: $description,'
        ' quantity: $_quantity,'
        ' unitPrice: $unitPrice)';
  }
}

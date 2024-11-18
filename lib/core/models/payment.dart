import 'dart:convert';

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

class PaymentModel {
  final String title;
  final double unitPrice;
  final int quantity;

  PaymentModel({
    required this.title,
    required this.unitPrice,
    required this.quantity,
  });

  @override
  String toString() => 'PaymentModel(amount: $unitPrice,'
      ' description: $title,'
      ' quantity: $quantity)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'unit_price': unitPrice,
      'quantity': quantity,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      unitPrice: map['unit_price'] as double,
      title: map['title'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

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

import 'package:bgbazzar/common/others/validators.dart';
import 'package:flutter/material.dart';

import '../../common/state_store/state_store.dart';

class EditAdStore extends StateStore {
  final imagesLength = ValueNotifier<int>(0);
  final hidePhone = ValueNotifier<bool>(false);

  String? name;
  String? description;
  String? mechanics;
  String? address;
  double? price;

  final errorName = ValueNotifier<String?>(null);
  final errorDescription = ValueNotifier<String?>(null);
  final errorAddress = ValueNotifier<String?>(null);
  final errorPrice = ValueNotifier<String?>(null);

  @override
  void dispose() {
    super.dispose();
    imagesLength.dispose();
    hidePhone.dispose();
    errorName.dispose();
    errorDescription.dispose();
    errorAddress.dispose();
    errorPrice.dispose();
  }

  setImagesLength(int value) {
    imagesLength.value = value;
  }

  setHidePhone(bool value) {
    hidePhone.value = value;
  }

  void setName(String value) {
    name = value;
    _validateName();
  }

  void _validateName() {
    errorName.value = Validator.name(name);
  }

  void setDescription(String value) {
    description = value;
    _validateDescription();
  }

  void _validateDescription() {
    errorDescription.value = description != null && description!.length > 12
        ? null
        : 'Dê uma descrição melhor sobre o estado do produto.';
  }

  void setAddress(String value) {
    address = value;
    _validateAddress();
  }

  void _validateAddress() {
    errorAddress.value = address != null && address!.length > 5
        ? null
        : 'Selecione um endereço valido.';
  }

  void setPrice(double value) {
    price = value;
    _validatePrice();
  }

  void _validatePrice() {
    errorPrice.value =
        price != null && price! > 0 ? null : 'Preencha o valor de seu produto.';
  }

  void setMechanics(String value) {
    mechanics = value;
  }

  bool get isValid {
    _validateName();
    _validateDescription();
    _validateAddress();
    _validatePrice();

    return imagesLength.value > 0 &&
        errorName.value == null &&
        errorDescription.value == null &&
        errorAddress.value == null &&
        errorPrice.value == null;
  }

  void resetStore() {
    imagesLength.value = 0;
    errorName.value = null;
    errorDescription.value = null;
    errorAddress.value = null;
    errorPrice.value = null;
  }
}

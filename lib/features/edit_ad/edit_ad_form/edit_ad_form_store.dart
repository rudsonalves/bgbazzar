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

import '/common/models/address.dart';
import '../../../common/models/ad.dart';
import '/common/state_store/state_store.dart';
import '/common/others/validators.dart';

class EditAdFormStore extends StateStore {
  final hidePhone = ValueNotifier<bool>(false);
  late final AdModel ad;

  final errorName = ValueNotifier<String?>(null);
  final errorDescription = ValueNotifier<String?>(null);
  final errorAddress = ValueNotifier<String?>(null);
  final errorPrice = ValueNotifier<String?>(null);

  void startAd(AdModel ad) {
    this.ad = ad;
  }

  @override
  void dispose() {
    super.dispose();
    hidePhone.dispose();
    errorName.dispose();
    errorDescription.dispose();
    errorAddress.dispose();
    errorPrice.dispose();
  }

  setHidePhone(bool value) {
    hidePhone.value = value;
  }

  void setName(String value) {
    ad.title = value;
    _validateName();
  }

  void _validateName() {
    errorName.value = Validator.name(ad.title);
  }

  void setDescription(String value) {
    ad.description = value;
    _validateDescription();
  }

  void _validateDescription() {
    errorDescription.value = ad.description.length > 12
        ? null
        : 'Dê uma descrição melhor sobre o estado do produto.';
  }

  void setAddress(AddressModel value) {
    ad.address = value;
    _validateAddress();
  }

  void _validateAddress() {
    errorAddress.value =
        ad.address != null ? null : 'Selecione um endereço valido.';
  }

  void setPrice(String strValue) {
    double value = double.tryParse(strValue) ?? 0.0;
    ad.price = value;
    _validatePrice();
  }

  void _validatePrice() {
    errorPrice.value = ad.price > 0 ? null : 'Preencha o valor de seu produto.';
  }

  void setMechanics(List<String> mechs) {
    ad.mechanicsPSIds = mechs;
  }

  bool get isValid {
    _validateName();
    _validateDescription();
    _validateAddress();
    _validatePrice();

    return errorName.value == null &&
        errorDescription.value == null &&
        errorAddress.value == null &&
        errorPrice.value == null;
  }

  void resetStore() {
    errorName.value = null;
    errorDescription.value = null;
    errorAddress.value = null;
    errorPrice.value = null;
  }
}

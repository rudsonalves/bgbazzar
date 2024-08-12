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

import '../../common/models/address.dart';
import '../../get_it.dart';
import '../../manager/address_manager.dart';
import '../../repository/parse_server/ad_repository.dart';
import 'address_state.dart';

class AddressController extends ChangeNotifier {
  final addressManager = getIt<AddressManager>();
  List<AddressModel> get addresses => addressManager.addresses;
  List<String> get addressNames => addressManager.addressNames.toList();

  final _selectedAddressName = ValueNotifier<String>('');
  ValueNotifier<String> get selectedAddressName => _selectedAddressName;
  String? get selectesAddresId {
    if (_selectedAddressName.value.isNotEmpty) {
      return addressManager.getAddressIdFromName(_selectedAddressName.value);
    }
    return null;
  }

  AddressState _state = AddressStateInitial();

  AddressState get state => _state;

  void _changeState(AddressState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    _selectedAddressName.dispose();
    super.dispose();
  }

  void selectAddress(String name) {
    if (addressNames.contains(name)) {
      _selectedAddressName.value = name;
    }
  }

  Future<void> removeAddress() async {
    final name = _selectedAddressName.value;
    if (name.isNotEmpty &&
        addressNames.isNotEmpty &&
        addressNames.contains(name)) {
      await addressManager.deleteByName(name);
      _selectedAddressName.value = '';
    }
  }

  Future<void> moveAdsAddressAndRemove({
    required List<String> adsList,
    required String? moveToId,
    required String removeAddressId,
  }) async {
    try {
      _changeState(AddressStateLoading());
      if (adsList.isNotEmpty && moveToId != null) {
        await AdRepository.moveAdsAddressTo(adsList, moveToId);
      }
      await addressManager.deleteById(removeAddressId);
      _changeState(AddressStateSuccess());
    } catch (err) {
      log(err.toString());
      _changeState(AddressStateError());
    }
  }

  void closeErroMessage() {
    _changeState(AddressStateSuccess());
  }
}

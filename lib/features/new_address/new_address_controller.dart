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
import '../../common/singletons/current_user.dart';
import '../../components/custon_field_controllers/masked_text_controller.dart';
import '../../get_it.dart';
import '../../repository/gov_api/viacep_repository.dart';
import 'new_address_state.dart';

class NewAddressController extends ChangeNotifier {
  NewAddressState _state = NewAddressStateInitial();

  NewAddressState get state => _state;

  void _changeState(NewAddressState newState) {
    _state = newState;
    notifyListeners();
  }

  final user = getIt<CurrentUser>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final zipCodeController = MaskedTextController(mask: '##.###-###');
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final complementController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  final zipFocus = FocusNode();
  final numberFocus = FocusNode();
  final complementFocus = FocusNode();
  final buttonFocus = FocusNode();

  List<AddressModel> get addresses => user.addresses;
  Iterable<String> get addressNames => user.addressNames;

  bool zipCodeReativit = true;

  bool get valid {
    return formKey.currentState != null && formKey.currentState!.validate();
  }

  void init() {
    zipCodeController.addListener(_checkZipCodeReady);
  }

  @override
  void dispose() {
    nameController.dispose();
    zipCodeController.dispose();
    streetController.dispose();
    numberController.dispose();
    complementController.dispose();
    neighborhoodController.dispose();
    cityController.dispose();
    stateController.dispose();
    numberFocus.dispose();
    complementFocus.dispose();
    buttonFocus.dispose();
    zipFocus.dispose();
    super.dispose();
  }

  void setFormFromAdresses(String addressName) {
    final address = user.addressByName(addressName);
    nameController.text = address!.name;
    zipCodeReativit = false;
    zipCodeController.text = address.zipCode;
    streetController.text = address.street;
    numberController.text = address.number;
    complementController.text = address.complement ?? '';
    neighborhoodController.text = address.neighborhood;
    cityController.text = address.city;
    stateController.text = address.state;
    zipCodeReativit = true;
  }

  Future<void> getAddressFromViacep() async {
    try {
      _changeState(NewAddressStateLoading());
      final response =
          await ViacepRepository.getLocalByCEP(zipCodeController.text);
      streetController.text = response.logradouro;
      neighborhoodController.text = response.bairro;
      cityController.text = response.localidade;
      stateController.text = response.uf;
      _changeState(NewAddressStateSuccess());
    } catch (err) {
      log(err.toString());
      _changeState(NewAddressStateError());
    }
  }

  Future<void> saveAddressFrom() async {
    try {
      _changeState(NewAddressStateLoading());
      final newAddress = AddressModel(
        name: nameController.text,
        zipCode: zipCodeController.text,
        userId: user.userId,
        street: streetController.text,
        number: numberController.text,
        complement: complementController.text,
        neighborhood: neighborhoodController.text,
        state: stateController.text,
        city: cityController.text,
      );
      await user.saveAddress(newAddress);
      _changeState(NewAddressStateSuccess());
    } catch (err) {
      log(err.toString());
      _changeState(NewAddressStateError());
    }
  }

  void _checkZipCodeReady() {
    if (!zipCodeReativit) return;
    final cleanZip = zipCodeController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanZip.length == 8) {
      getAddressFromViacep();
    } else {
      streetController.text = '';
      neighborhoodController.text = '';
      cityController.text = '';
      stateController.text = '';
    }
  }
}

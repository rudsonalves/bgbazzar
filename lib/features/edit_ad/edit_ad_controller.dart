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

import 'package:bgbazzar/repository/data/interfaces/i_ad_repository.dart';
import 'package:flutter/material.dart';

import '../../core/abstracts/data_result.dart';
import '/components/custon_controllers/currency_text_controller.dart';
import 'edit_ad_store.dart';
import '/core/singletons/current_user.dart';
import '/core/models/ad.dart';
import '/core/models/mechanic.dart';
import '/get_it.dart';
import '/data_managers/boardgames_manager.dart';
import '/data_managers/mechanics_manager.dart';

class EditAdController {
  late final EditAdStore store;
  final bgManager = getIt<BoardgamesManager>();
  final mechanicsManager = getIt<MechanicsManager>();
  final currentUser = getIt<CurrentUser>();
  final adRepository = getIt<IAdRepository>();

  String _selectedAddressId = '';
  ProductCondition _condition = ProductCondition.used;
  AdStatus _adStatus = AdStatus.pending;

  final nameController = TextEditingController();
  final priceController = CurrencyTextController();
  final quantityController = TextEditingController();
  final mechsController = TextEditingController();
  final addressController = TextEditingController();

  AdModel ad = AdModel(
    images: [],
    title: '',
    description: '',
    mechanicsIds: [],
    price: 0,
  );

  AdStatus get adStatus => _adStatus;
  String get selectedAddressId => _selectedAddressId;
  ProductCondition get condition => _condition;
  List<MechanicModel> get mechanics => mechanicsManager.mechanics;

  void init(EditAdStore store) {
    this.store = store;
  }

  void dispoase() {
    nameController.dispose();
    mechsController.dispose();
    priceController.dispose();
    quantityController.dispose();
    addressController.dispose();
  }

  Future<DataResult<AdModel>> saveAd() async {
    try {
      store.setStateLoading();
      final result = await adRepository.save(store.ad);
      if (result.isFailure) {
        throw Exception(result.error);
      }
      if (result.data == null) {
        throw Exception('IAdRepository.save return null');
      }
      store.setStateSuccess();

      return DataResult.success(result.data!);
    } catch (err) {
      final message = 'EditAdController.save: $err';
      log(message);
      store.setError('Ocorreu algum problema. Favor tente mais tarde');
      return DataResult.failure(GenericFailure(message: message));
    }
  }

  Future<void> setBgInfo(String bgId) async {
    try {
      store.setStateLoading();
      final result = await bgManager.getBoardgameId(bgId);
      if (result.isFailure) {
        throw Exception(result.error);
      }
      final bg = result.data;
      if (bg != null) {
        setMechanicsPsIds(bg.mechsPsIds);
        setName(bg.name);
        store.setBGInfo(bg);
        setMechanicsPsIds(bg.mechsPsIds);
      }
      log(store.ad.toString());
      store.setStateSuccess();
    } catch (err) {
      log(err.toString());
      const message = 'Estamos tendo algum problema com a conexão.'
          ' Tente novamente mais tarde.';
      store.setError(message);
    }
  }

  void setMechanicsPsIds(List<String> mechPsIds) {
    store.setMechanics(mechPsIds);
    mechsController.text = store.ad.mechanicsString;
  }

  void setSelectedAddress(String addressName) {
    final addressNames = currentUser.addressNames;
    if (addressNames.contains(addressName)) {
      final address = currentUser.addressByName(addressName)!;
      addressController.text = address.addressString();
      store.setAddress(address);
      _selectedAddressId = address.id!;
    }
  }

  void setCondition(ProductCondition newCondition) {
    _condition = newCondition;
  }

  void setAdStatus(AdStatus newStatus) {
    _adStatus = newStatus;
  }

  void setName(String name) {
    nameController.text = name;
    store.setName(name);
  }

  void setPrice(double price) {
    priceController.currencyValue = price;
    store.setPrice(price);
  }

  void setPriceString(String value) {
    store.setPrice(priceController.currencyValue);
  }
}

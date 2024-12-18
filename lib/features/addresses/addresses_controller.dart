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

import '../../core/models/address.dart';
import '../../get_it.dart';
import '../../data_managers/addresses_manager.dart';
import '../../repository/data/interfaces/i_ad_repository.dart';
import 'addresses_store.dart';

class AddressesController {
  final addressManager = getIt<AddressesManager>();
  late final AddressesStore store;
  final adRepository = getIt<IAdRepository>();

  List<AddressModel> get addresses => addressManager.addresses;
  List<String> get addressNames => addressManager.addressNames.toList();

  String? get selectesAddresId {
    if (store.selectedAddressName.value.isNotEmpty) {
      return addressManager.getAddressIdFromName(
        store.selectedAddressName.value,
      );
    }
    return null;
  }

  Future<void> init(AddressesStore store) async {
    this.store = store;
  }

  void selectAddress(String name) {
    if (addressNames.contains(name)) {
      if (name == store.selectedAddressName.value) {
        store.setSelectedAddressName('');
      } else {
        store.setSelectedAddressName(name);
      }
    }
  }

  Future<void> removeAddress() async {
    final name = store.selectedAddressName.value;
    if (name.isNotEmpty &&
        addressNames.isNotEmpty &&
        addressNames.contains(name)) {
      await addressManager.deleteByName(name);
      store.setSelectedAddressName('');
    }
  }

  Future<void> moveAdsAddressAndRemove({
    required List<String> adsList,
    required String? moveToId,
    required String removeAddressId,
  }) async {
    try {
      store.setStateLoading();
      if (adsList.isNotEmpty && moveToId != null) {
        final result = await adRepository.moveAdsAddressTo(adsList, moveToId);
        if (result.isFailure) {
          throw Exception(result.error);
        }
      }
      await addressManager.deleteById(removeAddressId);
      store.setStateSuccess();
    } catch (err) {
      log(err.toString());
      store.setError('Erro ao mover endereço. Tente mais tarde');
    }
  }

  void closeErroMessage() {
    store.setStateSuccess();
  }
}

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
import 'package:material_symbols_icons/symbols.dart';

import '../../components/widgets/state_error_message.dart';
import '../../components/widgets/state_loading_message.dart';
import '../../get_it.dart';
import '../../repository/data/interfaces/i_ad_repository.dart';
import 'edit_address/edit_address_screen.dart';
import 'addresses_controller.dart';
import 'addresses_store.dart';
import 'widgets/destiny_address_dialog.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  static const routeName = '/address';

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final ctrl = AddressesController();
  final store = AddressesStore();

  @override
  void initState() {
    super.initState();
    ctrl.init(store);
  }

  Future<void> _addAddress() async {
    await Navigator.pushNamed(context, EditAddressScreen.routeName);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _removeAddress() async {
    final addressId = ctrl.selectesAddresId;
    final adRepository = getIt<IAdRepository>();

    if (addressId != null) {
      final result = await adRepository.adsInAddress(addressId);
      if (result.isFailure) {
        // FIXME: complete this error handling
        throw Exception('AddressScreen._removeAddress err: ${result.error}');
      }
      final adsList = result.data!;

      if (adsList.isNotEmpty) {
        if (mounted) {
          final destiny = await DestinyAddressDialog.open(
            context,
            addressNames: ctrl.addressNames,
            addressRemoveName: store.selectedAddressName.value,
            adsListLength: adsList.length,
          );

          if (destiny != null) {
            final destinyId = ctrl.addressManager.getAddressIdFromName(destiny);
            if (destinyId != null) {
              ctrl.moveAdsAddressAndRemove(
                adsList: adsList,
                moveToId: destinyId,
                removeAddressId: addressId,
              );
            } else {
              log('Ocorreu um erro em _removeAddress');
            }
          }
        }
      } else {
        ctrl.moveAdsAddressAndRemove(
          adsList: [],
          moveToId: null,
          removeAddressId: addressId,
        );
      }
    }
  }

  void _backPage() {
    Navigator.pop(context, store.selectedAddressName.value);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereços'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: _backPage,
        ),
      ),
      floatingActionButton: OverflowBar(
        children: [
          FloatingActionButton(
            onPressed: _backPage,
            heroTag: 'fab0',
            tooltip: 'Retornar',
            // label: const Text('Selecionar'),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _addAddress,
            heroTag: 'fab1',
            tooltip: 'Adicionar Endereço',
            child: const Icon(Symbols.add_home_rounded),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _removeAddress,
            heroTag: 'fab2',
            tooltip: 'Remover Endereço',
            child: const Icon(Symbols.unsubscribe),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListenableBuilder(
          listenable:
              Listenable.merge([store.selectedAddressName, store.state]),
          builder: (context, _) {
            return Stack(
              children: [
                Column(
                  children: [
                    const Text('Selecione um endereço abaixo:'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: ctrl.addressNames.length,
                        itemBuilder: (context, index) {
                          final address = ctrl.addresses[index];
                          return Card(
                            color: address.name ==
                                    store.selectedAddressName.value
                                ? colorScheme.tertiaryContainer
                                : colorScheme.primaryContainer.withOpacity(0.4),
                            child: ListTile(
                              title: Text(address.name),
                              subtitle: Text(address.addressString()),
                              onTap: () => ctrl.selectAddress(address.name),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                if (store.isLoading) const StateLoadingMessage(),
                if (store.isError)
                  StateErrorMessage(
                    message: store.errorMessage,
                    closeDialog: ctrl.closeErroMessage,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

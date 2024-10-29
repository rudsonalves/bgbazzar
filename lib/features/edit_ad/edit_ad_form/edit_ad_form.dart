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

import '/get_it.dart';
import '../../../manager/mechanics_manager.dart';
import '/components/buttons/big_button.dart';
import '/common/models/ad.dart';
import '/components/form_fields/custom_form_field.dart';
import '/components/others_widgets/fitted_button_segment.dart';
import '../../address/address_screen.dart';
import '../../boardgame/boardgame_screen.dart';
import '../../mechanics/mechanics_screen.dart';
import 'edit_ad_form_controller.dart';
import 'edit_ad_form_store.dart';

class EditAdForm extends StatefulWidget {
  final AdModel ad;

  const EditAdForm({
    super.key,
    required this.ad,
  });

  @override
  State<EditAdForm> createState() => _EditAdFormState();
}

class _EditAdFormState extends State<EditAdForm> {
  final mechManager = getIt<MechanicsManager>();
  final store = EditAdFormStore();
  final ctrl = EditAdFormController();

  @override
  void initState() {
    super.initState();

    store.startAd(widget.ad);
    ctrl.init(store);
  }

  @override
  void dispose() {
    ctrl.dispoase();

    super.dispose();
  }

  Future<void> _selectMecanics() async {
    final mechPsIds = await Navigator.pushNamed(
      context,
      MechanicsScreen.routeName,
      arguments: store.ad.mechanicsPSIds,
    ) as List<String>?;

    if (mechPsIds != null) {
      ctrl.setMechanicsPsIds(mechPsIds);
      if (mounted) FocusScope.of(context).nextFocus();
    }
  }

  Future<void> _addAddress() async {
    final addressName =
        await Navigator.pushNamed(context, AddressScreen.routeName) as String;
    ctrl.setSelectedAddress(addressName);
  }

  Future<void> _getBGGInfo() async {
    final bgId = await Navigator.pushNamed(
      context,
      BoardgameScreen.routeName,
    ) as String?;

    if (bgId != null) {
      ctrl.setBgInfo(bgId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: store.errorName,
              builder: (context, erroName, _) {
                return CustomFormField(
                  controller: ctrl.nameController,
                  labelText: 'Nome do Jogo *',
                  fullBorder: false,
                  maxLines: null,
                  floatingLabelBehavior: null,
                  textCapitalization: TextCapitalization.sentences,
                  errorText: erroName,
                  onChanged: store.setName,
                );
              }),
          Center(
            child: BigButton(
              color: Colors.cyan,
              onPressed: _getBGGInfo,
              label: 'Informações do Jogo',
              iconData: Icons.info_outline_rounded,
            ),
          ),
          ValueListenableBuilder(
              valueListenable: store.errorDescription,
              builder: (context, errorDescription, _) {
                return CustomFormField(
                  initialValue: store.ad.description,
                  labelText: 'Descreva o estado do Jogo *',
                  fullBorder: false,
                  maxLines: null,
                  floatingLabelBehavior: null,
                  textCapitalization: TextCapitalization.sentences,
                  errorText: errorDescription,
                  onChanged: store.setDescription,
                );
              }),
          const Text('Produto'),
          Row(
            children: [
              Expanded(
                child: SegmentedButton<ProductCondition>(
                  segments: const [
                    ButtonSegment(
                      value: ProductCondition.used,
                      label: Text('Usado'),
                      icon: Icon(Icons.recycling),
                    ),
                    ButtonSegment(
                      value: ProductCondition.sealed,
                      label: Text('Lacrado'),
                      icon: Icon(Icons.new_releases_outlined),
                    ),
                  ],
                  selected: {ctrl.condition},
                  onSelectionChanged: (p0) {
                    setState(() {
                      ctrl.setCondition(p0.first);
                    });
                  },
                ),
              ),
            ],
          ),
          InkWell(
            onTap: _selectMecanics,
            child: AbsorbPointer(
              child: CustomFormField(
                controller: ctrl.mechsController,
                labelText: 'Mecânicas *',
                fullBorder: false,
                maxLines: null,
                floatingLabelBehavior: null,
                readOnly: true,
                suffixIcon: const Icon(Icons.ads_click),
                // onChanged: store.setMechanicsFromString,
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: store.errorAddress,
              builder: (context, errorAddress, _) {
                return InkWell(
                  onTap: _addAddress,
                  child: AbsorbPointer(
                    child: CustomFormField(
                      initialValue: store.ad.address?.addressString(),
                      labelText: 'Endereço *',
                      fullBorder: false,
                      maxLines: null,
                      floatingLabelBehavior: null,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.ads_click),
                      errorText: errorAddress,
                      // onChanged: store.setAddress,
                    ),
                  ),
                );
              }),
          CustomFormField(
            controller: ctrl.priceController,
            labelText: 'Preço *',
            fullBorder: false,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            floatingLabelBehavior: null,
            onChanged: store.setPrice,
          ),
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: store.hidePhone,
                builder: (context, value, _) {
                  return Checkbox(
                    value: value,
                    onChanged: (value) {
                      if (value != null) {
                        store.hidePhone.value = value;
                      }
                    },
                  );
                },
              ),
              const Expanded(
                child: Text('Ocultar meu telefone neste anúncio.'),
              ),
            ],
          ),
          const Text('Status do Anúncio'),
          Row(
            children: [
              Expanded(
                child: SegmentedButton<AdStatus>(
                  segments: [
                    FittedButtonSegment(
                      value: AdStatus.pending,
                      label: 'Pendente',
                      iconData: Icons.hourglass_empty,
                    ),
                    FittedButtonSegment(
                      value: AdStatus.active,
                      label: 'Ativo',
                      iconData: Icons.verified,
                    ),
                    FittedButtonSegment(
                      value: AdStatus.sold,
                      label: 'Vendido',
                      iconData: Icons.attach_money,
                    ),
                  ],
                  selected: {ctrl.adStatus},
                  onSelectionChanged: (p0) {
                    setState(() {
                      ctrl.setAdStatus(p0.first);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
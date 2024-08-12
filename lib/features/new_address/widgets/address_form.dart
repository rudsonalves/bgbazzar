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

import '../../../common/validators/validators.dart';
import '../../../components/form_fields/custom_form_field.dart';
import '../new_address_controller.dart';

class AddressForm extends StatefulWidget {
  final NewAddressController controller;
  final String? errorText;

  const AddressForm({
    super.key,
    required this.controller,
    required this.errorText,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  NewAddressController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomFormField(
            controller: controller.nameController,
            labelText: 'Endereço',
            hintText: 'Residencial, Comercial, ...',
            fullBorder: false,
            validator: AddressValidator.name,
            nextFocusNode: controller.zipFocus,
            textCapitalization: TextCapitalization.sentences,
          ),
          CustomFormField(
            labelText: 'CEP',
            controller: controller.zipCodeController,
            fullBorder: false,
            floatingLabelBehavior: null,
            validator: AddressValidator.zipCode,
            keyboardType: TextInputType.number,
            errorText: widget.errorText,
            focusNode: controller.zipFocus,
            nextFocusNode: controller.numberFocus,
            suffixIcon: IconButton(
              onPressed: controller.getAddressFromViacep,
              icon: const Icon(Icons.refresh),
            ),
          ),
          CustomFormField(
            labelText: 'Logadouro',
            controller: controller.streetController,
            fullBorder: false,
            readOnly: true,
            floatingLabelBehavior: null,
            validator: AddressValidator.street,
            suffixIcon: const Icon(Icons.auto_fix_high),
          ),
          CustomFormField(
            labelText: 'Número',
            controller: controller.numberController,
            fullBorder: false,
            floatingLabelBehavior: null,
            validator: AddressValidator.number,
            keyboardType: TextInputType.streetAddress,
            focusNode: controller.numberFocus,
            nextFocusNode: controller.complementFocus,
          ),
          CustomFormField(
            labelText: 'Complemento',
            controller: controller.complementController,
            fullBorder: false,
            floatingLabelBehavior: null,
            focusNode: controller.complementFocus,
            nextFocusNode: controller.buttonFocus,
            textCapitalization: TextCapitalization.sentences,
          ),
          CustomFormField(
            labelText: 'Bairro',
            controller: controller.neighborhoodController,
            fullBorder: false,
            readOnly: true,
            floatingLabelBehavior: null,
            validator: AddressValidator.neighborhood,
            suffixIcon: const Icon(Icons.auto_fix_high),
          ),
          CustomFormField(
            labelText: 'Estado',
            controller: controller.stateController,
            fullBorder: false,
            readOnly: true,
            floatingLabelBehavior: null,
            validator: AddressValidator.state,
            suffixIcon: const Icon(Icons.auto_fix_high),
          ),
          CustomFormField(
            labelText: 'Cidade',
            controller: controller.cityController,
            fullBorder: false,
            readOnly: true,
            floatingLabelBehavior: null,
            validator: AddressValidator.city,
            suffixIcon: const Icon(Icons.auto_fix_high),
          ),
        ],
      ),
    );
  }
}

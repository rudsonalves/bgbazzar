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

import '../../../common/others/validators.dart';
import '../../../components/buttons/big_button.dart';
import '../../../components/form_fields/custom_form_field.dart';
import '../../../components/form_fields/custom_mask_field.dart';
import '../../../components/form_fields/password_form_field.dart';
import '../signup_store.dart';

class SignUpForm extends StatelessWidget {
  final SignupStore store;
  final void Function() signupUser;
  final void Function() navLogin;

  const SignUpForm({
    super.key,
    required this.store,
    required this.signupUser,
    required this.navLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder(
            valueListenable: store.errorName,
            builder: (context, errorName, _) {
              return CustomFormField(
                labelText: 'Nome',
                hintText: 'Como aparecerá em seus anúncios',
                errorText: errorName,
                onChanged: store.setName,
                validator: Validator.name,
                textCapitalization: TextCapitalization.words,
                // nextFocusNode: controller.emailFocusNode,
              );
            }),
        ValueListenableBuilder(
            valueListenable: store.errorEmail,
            builder: (context, errorEmail, _) {
              return CustomFormField(
                labelText: 'E-mail',
                hintText: 'seu-email@provedor.com',
                errorText: errorEmail,
                onChanged: store.setEmail,
                validator: Validator.email,
                keyboardType: TextInputType.emailAddress,
                // focusNode: controller.emailFocusNode,
                // nextFocusNode: controller.phoneFocusNode,
              );
            }),
        ValueListenableBuilder(
            valueListenable: store.errorPhone,
            builder: (context, errorPhone, _) {
              return CustomMaskField(
                labelText: 'Celular',
                hintText: '(19) 9999-9999',
                mask: '(##) #####-####',
                errorText: errorPhone,
                onChanged: store.setPhone,

                keyboardType: TextInputType.phone,
                // focusNode: controller.phoneFocusNode,
                // nextFocusNode: controller.passwordFocusNode,
              );
            }),
        ValueListenableBuilder(
            valueListenable: store.errorPassword,
            builder: (context, errorPassword, _) {
              return PasswordFormField(
                labelText: 'Senha',
                hintText: '6+ letras e números',
                errorText: errorPassword,
                onChanged: store.setPassword,
                textInputAction: TextInputAction.next,
                // nextFocusNode: controller.checkPassFocusNode,
              );
            }),
        ValueListenableBuilder(
            valueListenable: store.errorCheckPassword,
            builder: (context, errorCheckPassword, _) {
              return PasswordFormField(
                labelText: 'Confirmar senha',
                hintText: '6+ letras e números',
                errorText: errorCheckPassword,
                onChanged: store.setCheckPassword,
              );
            }),
        BigButton(
          color: Colors.amber,
          label: 'Registrar',
          onPressed: signupUser,
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Possui uma conta?'),
            TextButton(
              onPressed: navLogin,
              child: const Text('Entrar'),
            ),
          ],
        ),
      ],
    );
  }
}

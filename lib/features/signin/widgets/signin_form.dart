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

import '../../../components/buttons/big_button.dart';
import '../../../components/form_fields/custom_form_field.dart';
import '../../../components/form_fields/password_form_field.dart';
import '../signin_store.dart';

class SignInForm extends StatelessWidget {
  final SignInStore store;
  final void Function() userLogin;
  final void Function() navSignUp;
  final void Function() navLostPassword;

  const SignInForm({
    super.key,
    required this.store,
    required this.userLogin,
    required this.navSignUp,
    required this.navLostPassword,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder(
            valueListenable: store.errorEmail,
            builder: (context, errorEmail, _) {
              return CustomFormField(
                labelText: 'E-mail',
                hintText: 'seu-email@provedor.com',
                keyboardType: TextInputType.emailAddress,
                errorText: errorEmail,
                onChanged: store.setEmail,
              );
            }),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: navLostPassword,
            child: Text(
              'Esqueceu a senha?',
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 12,
              ),
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: store.errorPassword,
          builder: (context, errorPassword, _) {
            return PasswordFormField(
              labelText: 'Senha',
              errorText: errorPassword,
              onChanged: store.setPassword,
            );
          },
        ),
        BigButton(
          color: Colors.amber,
          label: 'Entrar',
          onPressed: userLogin,
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Não possui uma conta?'),
            TextButton(
              onPressed: navSignUp,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ],
    );
  }
}

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
import '../../../components/buttons/big_button.dart';
import '../../../components/form_fields/custom_form_field.dart';
import '../../../components/form_fields/password_form_field.dart';
import '../login_controller.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LoginController controller;
  final void Function() userLogin;
  final void Function() navSignUp;
  final void Function() navLostPassword;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.userLogin,
    required this.navSignUp,
    required this.navLostPassword,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Text('Acessar com E-mail'),
          CustomFormField(
            labelText: 'E-mail',
            hintText: 'seu-email@provedor.com',
            controller: controller.emailController,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress,
            nextFocusNode: controller.passwordFocusNode,
          ),
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
          PasswordFormField(
            labelText: 'Senha',
            passwordController: controller.passwordController,
            validator: Validator.password,
            focusNode: controller.passwordFocusNode,
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
      ),
    );
  }
}

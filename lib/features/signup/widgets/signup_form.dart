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
import '../signup_controller.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SignupController controller;
  final void Function() signupUser;
  final void Function() navLogin;

  const SignUpForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.signupUser,
    required this.navLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomFormField(
            labelText: 'Nome',
            hintText: 'Como aparecerá em seus anúncios',
            controller: controller.nameController,
            validator: Validator.name,
            nextFocusNode: controller.emailFocusNode,
          ),
          CustomFormField(
            labelText: 'E-mail',
            hintText: 'seu-email@provedor.com',
            controller: controller.emailController,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress,
            focusNode: controller.emailFocusNode,
            nextFocusNode: controller.phoneFocusNode,
          ),
          CustomFormField(
            labelText: 'Celular',
            hintText: '(19) 9999-9999',
            controller: controller.phoneController,
            validator: Validator.phone,
            keyboardType: TextInputType.phone,
            focusNode: controller.phoneFocusNode,
            nextFocusNode: controller.passwordFocusNode,
          ),
          PasswordFormField(
            labelText: 'Senha',
            hintText: '6+ letras e números',
            passwordController: controller.passwordController,
            validator: Validator.password,
            focusNode: controller.passwordFocusNode,
            textInputAction: TextInputAction.next,
            nextFocusNode: controller.checkPassFocusNode,
          ),
          PasswordFormField(
            labelText: 'Confirmar senha',
            hintText: '6+ letras e números',
            passwordController: controller.checkPasswordController,
            focusNode: controller.checkPassFocusNode,
            validator: (value) => Validator.checkPassword(
              controller.passwordController.text,
              value,
            ),
          ),
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
      ),
    );
  }
}

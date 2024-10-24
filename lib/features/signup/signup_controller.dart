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

import '../../common/models/user.dart';
import '../../common/singletons/app_settings.dart';
import '../../components/custon_field_controllers/masked_text_controller.dart';
import '../../get_it.dart';
import '../../repository/parse_server/ps_user_repository.dart';
import 'signup_store.dart';

class SignupController {
  late final SignupStore store;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final checkPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = MaskedTextController(mask: '(##) ####-#####');

  final app = getIt<AppSettings>();

  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final checkPassFocusNode = FocusNode();

  void init(SignupStore store) {
    this.store = store;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    checkPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();

    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    checkPassFocusNode.dispose();
  }

  Future<UserModel?> signupUser() async {
    try {
      store.setStateLoading();
      final user = UserModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
      final newUser = await PSUserRepository.signUp(user);
      store.setStateSuccess();
      return newUser;
    } catch (err) {
      store.setError('Ocorreu um erro. Tente mais tarde.');
      throw Exception(err);
    }
  }
}

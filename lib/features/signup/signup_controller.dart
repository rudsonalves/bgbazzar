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
import '../../repository/parse_server/user_repository.dart';
import 'signup_state.dart';

class SignupController extends ChangeNotifier {
  SignUpState _state = SignUpStateInitial();

  SignUpState get state => _state;

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

  @override
  void dispose() {
    super.dispose();
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

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<UserModel?> signupUser() async {
    try {
      _changeState(SignUpStateLoading());
      final user = UserModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
      final newUser = await UserRepository.signUp(user);
      _changeState(SignUpStateSuccess());
      return newUser;
    } catch (err) {
      _changeState(SignUpStateError());
      throw Exception(err);
    }
  }
}

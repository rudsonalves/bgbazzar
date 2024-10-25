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

import '../../common/others/validators.dart';
import '../../common/state_store/state_store.dart';

class SignInStore extends StateStore {
  final errorEmail = ValueNotifier<String?>(null);
  final errorPassword = ValueNotifier<String?>(null);

  String? email;
  String? password;

  @override
  void dispose() {
    super.dispose();
    errorEmail.dispose();
    errorPassword.dispose();
  }

  void setEmail(String value) {
    email = value;
    validateEmail();
  }

  void validateEmail() {
    errorEmail.value = Validator.email(email);
  }

  void setPassword(String value) {
    password = value;
    validatePassword();
  }

  void validatePassword() {
    errorPassword.value = Validator.password(password);
  }

  bool isValid() {
    validateEmail();
    validatePassword();

    return errorEmail.value == null && errorPassword.value == null;
  }
}

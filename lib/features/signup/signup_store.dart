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

import '../../core/utils/validators.dart';
import '../../core/state/state_store.dart';

class SignupStore extends StateStore {
  final errorName = ValueNotifier<String?>(null);
  final errorEmail = ValueNotifier<String?>(null);
  final errorPhone = ValueNotifier<String?>(null);
  final errorPassword = ValueNotifier<String?>(null);
  final errorCheckPassword = ValueNotifier<String?>(null);

  String? name;
  String? email;
  String? phone;
  String? password;
  String? checkPassword;

  @override
  void dispose() {
    super.dispose();
    errorName.dispose();
    errorEmail.dispose();
    errorPhone.dispose();
    errorPassword.dispose();
    errorCheckPassword.dispose();
  }

  void setName(String value) {
    name = value;
    validateName();
  }

  void validateName() {
    errorName.value = (name != null && name!.length < 3)
        ? 'Nome deve ter 3 ou mais caracteres'
        : null;
  }

  void setEmail(String value) {
    email = value;
    validateEmail();
  }

  void validateEmail() {
    errorEmail.value = Validator.email(email);
  }

  void setPhone(String value) {
    phone = value;
    validatePhone();
  }

  void validatePhone() {
    errorPhone.value = Validator.phone(phone);
  }

  void setPassword(String value) {
    password = value;
    validatePassword();
  }

  void validatePassword() {
    errorPassword.value = Validator.password(password);
  }

  void setCheckPassword(String value) {
    checkPassword = value;
    validateCheckPassword();
  }

  void validateCheckPassword() {
    errorCheckPassword.value = Validator.checkPassword(password, checkPassword);
  }

  bool isValid() {
    validateName();
    validateEmail();
    validatePhone();
    validatePassword();
    validateCheckPassword();

    return errorName.value == null &&
        errorEmail.value == null &&
        errorPhone.value == null &&
        errorPassword.value == null &&
        errorCheckPassword.value == null;
  }
}

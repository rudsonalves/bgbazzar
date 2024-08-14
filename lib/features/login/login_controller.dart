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
import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import '../../repository/parse_server/ps_user_repository.dart';
import 'login_state.dart';

class LoginController extends ChangeNotifier {
  LoginState _state = LoginStateInitial();

  LoginState get state => _state;

  void _changeState(LoginState newState) {
    _state = newState;
    notifyListeners();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final app = getIt<AppSettings>();
  final currentUser = getIt<CurrentUser>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  Future<UserModel?> login(UserModel user) async {
    try {
      _changeState(LoginStateLoading());
      final newUser = await PSUserRepository.loginWithEmail(user);
      currentUser.init(newUser);
      _changeState(LoginStateSuccess());
      return newUser;
    } catch (err) {
      _changeState(LoginStateError());
      throw Exception(err);
    }
  }

  void closeErroMessage() {
    _changeState(LoginStateSuccess());
  }
}

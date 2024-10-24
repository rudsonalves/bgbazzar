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

import '../../common/models/user.dart';
import '../../common/singletons/app_settings.dart';
import '../../get_it.dart';
import '../../repository/parse_server/ps_user_repository.dart';
import 'signup_store.dart';

class SignupController {
  late final SignupStore store;

  final app = getIt<AppSettings>();

  void init(SignupStore store) {
    this.store = store;
  }

  void dispose() {}

  Future<UserModel?> signupUser() async {
    try {
      store.setStateLoading();
      final user = UserModel(
        name: store.name!,
        email: store.email!,
        phone: store.phone!,
        password: store.password!,
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

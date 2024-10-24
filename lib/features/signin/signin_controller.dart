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

import '../../common/abstracts/data_result.dart';
import '../../common/models/user.dart';
import '../../common/singletons/app_settings.dart';
import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import '../../repository/parse_server/ps_user_repository.dart';
import 'signin_store.dart';

class SignInController {
  late final SignInStore store;

  final app = getIt<AppSettings>();
  final currentUser = getIt<CurrentUser>();

  init(SignInStore store) {
    this.store = store;
  }

  Future<DataResult<void>> login() async {
    try {
      store.setStateLoading();
      final user = UserModel(
        email: store.email!,
        password: store.password!,
      );
      final newUser = await PSUserRepository.loginWithEmail(user);
      currentUser.init(newUser);
      store.setStateSuccess();
      return DataResult.success(null);
    } catch (err) {
      const message = 'Ocorreu um erro. Tente mais tarde.';
      store.setError(message);
      return DataResult.failure(const GenericFailure(message));
    }
  }

  void closeErroMessage() {
    store.setStateSuccess();
  }
}

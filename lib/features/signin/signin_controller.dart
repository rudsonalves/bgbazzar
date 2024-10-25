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

import '/repository/interfaces/iuser_repository.dart';
import '../../common/abstracts/data_result.dart';
import '../../common/models/user.dart';
import '../../common/singletons/app_settings.dart';
import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import 'signin_store.dart';

enum RecoverStatus { error, success, fail }

class SignInController {
  late final SignInStore store;
  final userRepository = getIt<IUserRepository>();

  final app = getIt<AppSettings>();
  final currentUser = getIt<CurrentUser>();

  init(SignInStore store) {
    this.store = store;
  }

  Future<DataResult<void>> login() async {
    store.setStateLoading();
    final user = UserModel(
      email: store.email!,
      password: store.password!,
    );
    final result = await userRepository.signInWithEmail(user);
    if (result.isFailure) {
      store.setError(result.error!.message!);
      return DataResult.failure(const GenericFailure());
    }
    final newUser = result.data;
    currentUser.init(newUser);
    store.setStateSuccess();
    return DataResult.success(null);
  }

  void closeErroMessage() {
    store.setStateSuccess();
  }

  Future<RecoverStatus> recoverPassword() async {
    store.setStateLoading();
    store.validateEmail();
    if (store.errorEmail.value != null) {
      store.setStateSuccess();
      return RecoverStatus.fail;
    }
    final result = await userRepository.resetPassword(store.email!);
    if (result.isFailure) {
      store.setError(result.error!.message!);
      return RecoverStatus.error;
    }
    store.setStateSuccess();
    return RecoverStatus.success;
  }
}

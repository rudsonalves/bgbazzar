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

import 'dart:developer';

import '../../../core/abstracts/data_result.dart';

class LocalFunctions {
  LocalFunctions._();

  static DataResult<T> handleError<T>(
      String className, String module, Object error) {
    final fullMessage = '$className.$module: $error';
    log(fullMessage);
    return DataResult.failure(GenericFailure(message: fullMessage));
  }
}

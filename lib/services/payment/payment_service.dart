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

import 'dart:async';
import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../core/abstracts/data_result.dart';
import '../../core/models/payment.dart';

class PaymentService {
  PaymentService._();

  static Future<DataResult<String>> getPreferenceId(PaymentModel pay) async {
    final function = ParseCloudFunction('createPreference');
    final parameters = {
      'amount': pay.amount,
      'description': pay.description,
      'quantity': pay.quantity,
    };

    try {
      // Adiciona um timeout de 10 segundos à chamada da função Cloud
      final response = await function
          .execute(parameters: parameters)
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Timed out while trying to get preferenceId.');
      });

      // Verifica a resposta
      if (response.success && response.result != null) {
        return DataResult.success(response.result['preferenceId'] as String);
      } else {
        final message =
            'Error getting preferenceId: ${response.error?.message}';
        log(message);
        return DataResult.failure(
            APIFailure(message: message, code: response.error?.code ?? 0));
      }
    } on TimeoutException catch (e) {
      // Tratamento de Timeout
      final message = 'Timeout error: ${e.message}';
      log(message);
      return DataResult.failure(TimeoutFailure(message: message));
    } catch (e) {
      // Tratamento de outros erros inesperados
      final message = 'Unexpected error: $e';
      log(message);
      return DataResult.failure(GenericFailure(message: message));
    }
  }
}

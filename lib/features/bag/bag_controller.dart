// ignore_for_file: public_member_api_docs, sort_constructors_first
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

import '/core/abstracts/data_result.dart';
import '/core/models/ad.dart';
import '/core/models/bag_item.dart';
import '/data_managers/ad_manager.dart';
import '/data_managers/bag_manager.dart';
import '/get_it.dart';
import '/services/payment/payment_service.dart';
import 'bag_store.dart';

class BagController {
  final BagStore store;
  final bagManager = getIt<BagManager>();
  final adManager = getIt<AdManager>();

  Set<BagItemModel> items(String sellerId) => bagManager.bagBySeller[sellerId]!;

  BagController(this.store) {
    initialize();
  }

  Future<void> initialize() async {
    store.setStateLoading();
    Future.delayed(const Duration(milliseconds: 50));
    store.setStateSuccess();
  }

  Future<DataResult<AdModel>> getAdById(String adId) async {
    store.setStateLoading();
    final result = await adManager.getAdById(adId);
    store.setStateSuccess();
    return result;
  }

  Future<String?> getPreferenceId(List<BagItemModel> items) async {
    try {
      store.setStateLoading();
      final result = await PaymentService.generatePreferenceId(items);
      if (result.isFailure) {
        throw Exception(
            'makePayment erro: ${result.error?.toString() ?? 'unknow error!'}');
      }
      store.setStateSuccess();
      return result.data!;
    } catch (err) {
      store.setError('Ocorreu um erro. Tente mais tarde.');
      return null;
    }
  }

  double calculateAmount(List<BagItemModel> items) {
    return items.fold(0, (sum, item) => sum + item.quantity * item.unitPrice);
  }
}

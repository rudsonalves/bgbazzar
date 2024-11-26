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

import 'package:bgbazzar/components/widgets/state_error_message.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'payment_controller.dart';
import 'payment_store.dart';

class PaymentScreen extends StatefulWidget {
  final String preferenceId;
  final double amount;

  const PaymentScreen({
    super.key,
    required this.preferenceId,
    required this.amount,
  });

  static const routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ctrl = PaymentController();
  final store = PaymentStore();

  @override
  void initState() {
    super.initState();

    ctrl.init(
      context,
      store: store,
      preferenceId: widget.preferenceId,
      amount: widget.amount,
    );
  }

  @override
  void dispose() {
    store.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
      ),
      body: ValueListenableBuilder(
        valueListenable: store.state,
        builder: (context, value, _) {
          if (store.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          if (store.isSuccess) {
            return WebViewWidget(controller: ctrl.webview);
          }
          if (store.isError) {
            StateErrorMessage(
              message: store.errorMessage,
              closeDialog: store.setStateSuccess,
            );
          }
          return Container();
        },
      ),
    );
  }
}

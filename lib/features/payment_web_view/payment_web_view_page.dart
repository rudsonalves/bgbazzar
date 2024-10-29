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
import 'package:webview_flutter/webview_flutter.dart';

import 'payment_controller.dart';
import 'payment_store.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String preferenceId;

  const PaymentWebViewPage({
    super.key,
    required this.preferenceId,
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  final ctrl = PaymentController();
  final store = PaymentStore();

  @override
  void initState() {
    super.initState();

    ctrl.init(widget.preferenceId, store);
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.isSuccess) {
            return WebViewWidget(controller: ctrl.webview);
          }
          if (store.isError) {
            return Center(
              child: Text(
                  'Desculpe, ocorreu um erro. Por favor, tende mais tarde.'),
            );
          }
          return Container();
        },
      ),
    );
  }
}

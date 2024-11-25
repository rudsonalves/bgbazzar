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
import 'package:webview_flutter/webview_flutter.dart';

import 'payment_store.dart';

class PaymentController {
  late final WebViewController webview;
  late final PaymentStore store;
  late final String preferenceId;
  late final double amount;

  void init({
    required PaymentStore store,
    required String preferenceId,
    required double amount,
  }) {
    this.store = store;

    this.preferenceId = preferenceId;
    this.amount = amount;

    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      store.setStateLoading();
      webview = WebViewController()
        // Enable JavaScript for Payment Brick
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            // Can display a progress bar or something similar
            onProgress: (int progress) => log('Loading progress $progress%'),
            onPageStarted: (String url) => log('Page started loading: $url'),
            onPageFinished: (String url) => log('Page loaded: $url'),
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.contains("success_url")) {
                store.setStateSuccess();
                return NavigationDecision.prevent;
              } else if (request.url.contains("failure_url")) {
                store.setError('Falha no pagemento!');
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onWebResourceError: (WebResourceError error) {
              log('Error loading resource: ${error.description}');
              store.setError('Ocoreu um erro. Tente mais tarde');
            },
          ),
        );

      // Sets the initial URL to be loaded
      String url =
          'https://bgshop.b4a.app/payment_page.html?preferenceId=$preferenceId&amount=${amount.toStringAsFixed(2)}';
      await webview.loadRequest(Uri.parse(url));
      store.setStateSuccess();
    } catch (err) {
      log('Erro ao inicializar o WebView: $err');
      store.setError('Erro ao inicializar a página de pagamento.');
    }
  }
}

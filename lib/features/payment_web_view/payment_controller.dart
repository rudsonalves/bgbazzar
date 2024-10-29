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
  late WebViewController webview;
  late final PaymentStore store;

  void init(String preferenceId, PaymentStore store) {
    this.store = store;

    _initializeController(preferenceId);
  }

  Future<void> _initializeController(String preferenceId) async {
    store.setStateLoading();
    webview = WebViewController()
      ..setJavaScriptMode(
          JavaScriptMode.unrestricted) // Enable JavaScript for Payment Brick
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Can display a progress bar or something similar
            log('Loading progress $progress%');
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {
            log('Page loaded: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Navigation control - if necessary, prevent navigation to unwanted URLs
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            log('Error loading resource: ${error.description}');
            store.setStateError();
          },
        ),
      );

    // Sets the initial URL to be loaded
    String url =
        'https://bgshop.back4app.io/payment_page.html?preferenceId=$preferenceId';
    await webview.loadRequest(Uri.parse(url));
    store.setStateSuccess();
  }
}

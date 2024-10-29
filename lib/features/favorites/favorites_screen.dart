// Copyright (C) 2024 rudson
//
// This file is part of xlo_mobx.
//
// xlo_mobx is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// xlo_mobx is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with xlo_mobx.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';

import '../../components/others_widgets/shop_grid_view/shop_grid_view.dart';
import '../../components/others_widgets/state_loading_message.dart';
import '../shop/shop_controller.dart';
import '../shop/shop_store.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static const routeName = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ctrl = ShopController();
  final store = ShopStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ctrl.init(store);
  }

  void _backPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _backPage,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimatedBuilder(
            animation: store.state,
            builder: (context, _) {
              return Stack(
                children: [
                  ShopGridView(
                    ctrl: ctrl,
                    scrollController: _scrollController,
                  ),
                  if (store.isLoading) const StateLoadingMessage()
                ],
              );
            }),
      ),
    );
  }
}

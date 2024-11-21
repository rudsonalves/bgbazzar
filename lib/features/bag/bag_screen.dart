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

import 'package:flutter/material.dart';

import '/components/widgets/state_error_message.dart';
import '/components/widgets/state_loading_message.dart';
import '../../data_managers/bag_manager.dart';
import '../../get_it.dart';
import 'bag_controller.dart';
import 'bag_store.dart';
import 'widgets/saller_bag.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  static const routeName = '/bag';

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  final store = BagStore();
  late final BagController ctrl;
  final bagManager = getIt<BagManager>();

  @override
  void initState() {
    super.initState();

    ctrl = BagController(store);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: Listenable.merge(
              [bagManager.refreshList, store.state],
            ),
            builder: (context, _) {
              if (store.isLoading) {
                return StateLoadingMessage();
              } else if (store.isSuccess) {
                final List<Widget> sellers = [];
                for (final seller in bagManager.sellers) {
                  sellers.add(SallerBag(ctrl: ctrl, saller: seller));
                }
                return Column(
                  children: [...sellers],
                );
              } else {
                return StateErrorMessage(closeDialog: store.setStateSuccess);
              }
            },
          ),
        ),
      ),
    );
  }
}

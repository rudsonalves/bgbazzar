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

import '../../common/singletons/app_settings.dart';
import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import 'widgets/admin_hooks.dart';
import 'widgets/config_hooks.dart';
import 'widgets/sales_hooks.dart';
import 'widgets/shopping_hooks.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  static const routeName = '/account';

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final currentUser = getIt<CurrentUser>();
  final app = getIt<AppSettings>();

  void _backPage() {
    Navigator.pop(context);
  }

  void _logout() async {
    if (mounted) Navigator.pop(context);
    await currentUser.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Conta'),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _backPage,
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: app.brightness,
            builder: (context, value, _) {
              return IconButton(
                onPressed: app.toggleBrightnessMode,
                icon: Icon(value == Brightness.dark
                    ? Icons.dark_mode
                    : Icons.light_mode),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(currentUser.user!.name!),
                subtitle: Text(currentUser.user!.email),
                trailing: IconButton(
                  icon: const Icon(Icons.power_settings_new_rounded),
                  onPressed: _logout,
                ),
              ),
              const AdminHooks(),
              const ShoppingHooks(),
              const SalesHooks(),
              const Divider(),
              const ConfigHooks(),
            ],
          ),
        ),
      ),
    );
  }
}

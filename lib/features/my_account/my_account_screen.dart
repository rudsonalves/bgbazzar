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

import '../../common/singletons/current_user.dart';
import '../../get_it.dart';
import '../address/address_screen.dart';
import '../my_ads/my_ads_screen.dart';
import '../my_data/my_data_screen.dart';
import '../product/widgets/title_product.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  static const routeName = '/account';

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final currentUser = getIt<CurrentUser>();

  void _backPage() {
    Navigator.pop(context);
  }

  void _logout() async {
    if (mounted) Navigator.pop(context);
    await currentUser.logout();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Conta'),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _backPage,
        ),
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
              const Divider(),
              const TitleProduct(title: 'Compras'),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favoritos'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Perguntas'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Minhas Compras'),
                onTap: () {},
              ),
              const Divider(),
              TitleProduct(
                title: 'Vendas',
                color: primary,
              ),
              ListTile(
                leading: const Icon(Icons.text_snippet),
                title: const Text('Resumo'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.discount, color: primary),
                title: Text(
                  'Anúncios',
                  style: TextStyle(color: primary),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyAdsScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.forum_outlined),
                title: const Text('Perguntas'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('Vendas'),
                onTap: () {},
              ),
              const Divider(),
              TitleProduct(title: 'Configurações', color: primary),
              ListTile(
                leading: Icon(Icons.person, color: primary),
                title: Text('Meus Dados', style: TextStyle(color: primary)),
                onTap: () =>
                    Navigator.pushNamed(context, MyDataScreen.routeName),
              ),
              ListTile(
                leading: Icon(Icons.contact_mail_rounded, color: primary),
                title: Text('Meus Endereços', style: TextStyle(color: primary)),
                onTap: () =>
                    Navigator.pushNamed(context, AddressScreen.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

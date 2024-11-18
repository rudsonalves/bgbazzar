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

import '../../addresses/addresses_screen.dart';
import '../my_data/my_data_screen.dart';
import '../../shop/product/widgets/title_product.dart';

class ConfigHooks extends StatelessWidget {
  const ConfigHooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleProduct(title: 'Meus Dados', color: primary),
        ListTile(
          leading: Icon(Icons.person, color: primary),
          title: Text('Dados', style: TextStyle(color: primary)),
          onTap: () => Navigator.pushNamed(context, MyDataScreen.routeName),
        ),
        ListTile(
          leading: Icon(Icons.contact_mail_rounded, color: primary),
          title: Text('Endereços', style: TextStyle(color: primary)),
          onTap: () => Navigator.pushNamed(context, AddressesScreen.routeName),
        ),
      ],
    );
  }
}
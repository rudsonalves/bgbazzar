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

import '../../core/models/ad.dart';
import '../../get_it.dart';
import '../../data_managers/favorites_manager.dart';

class FavoriteStackButton extends StatelessWidget {
  final AdModel ad;

  FavoriteStackButton({
    super.key,
    required this.ad,
  });

  final favoritesManager = getIt<FavoritesManager>();
  List<String> get favAdIds => favoritesManager.favAdIds;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: ListenableBuilder(
              listenable: favoritesManager.favNotifier,
              builder: (context, _) {
                return Icon(
                  favAdIds.contains(ad.id!)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                );
              }),
          onPressed: () => favoritesManager.toggleAdFav(ad),
        ),
      ],
    );
  }
}

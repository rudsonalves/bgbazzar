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

import '/core/models/bg_name.dart';

class SearchCard extends StatelessWidget {
  final List<BGNameModel> bgSearchList;
  final void Function(String id) getBoardInfo;

  const SearchCard({
    super.key,
    required this.getBoardInfo,
    required this.bgSearchList,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 200,
      child: Card(
        color: colorScheme.surfaceContainer,
        margin: const EdgeInsets.all(8),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: bgSearchList.length,
          itemBuilder: (context, index) {
            final bgBoard = bgSearchList[index];

            return ListTile(
              onTap: () {
                getBoardInfo(bgBoard.id!);
              },
              title: Text(bgBoard.name!),
              // subtitle: Text(
              //   'Publicado em ${bgBoard.yearpublished ?? '***'}',
              // ),
            );
          },
        ),
      ),
    );
  }
}

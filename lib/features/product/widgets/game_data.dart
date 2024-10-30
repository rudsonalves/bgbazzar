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

import '../../../common/models/ad.dart';
import '../../../common/theme/app_text_style.dart';
import 'sub_title_product.dart';

class GameData extends StatelessWidget {
  final AdModel ad;
  final double indent;

  const GameData({
    super.key,
    required this.ad,
    required this.indent,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(indent: indent, endIndent: indent),
        SubTitleProduct(
          subtile: 'Dados do Jogo',
          color: primary,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: ad.boardgame!.minPlayers.toString(),
                style: AppTextStyle.font16Bold,
              ),
              const TextSpan(text: ' a '),
              TextSpan(
                text: ad.boardgame!.maxPlayers.toString(),
                style: AppTextStyle.font16Bold,
              ),
              const TextSpan(text: ' Jogadores'),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: ad.boardgame!.minTime.toString(),
                style: AppTextStyle.font16Bold,
              ),
              const TextSpan(text: ' a '),
              TextSpan(
                text: ad.boardgame!.maxTime.toString(),
                style: AppTextStyle.font16Bold,
              ),
              const TextSpan(text: ' minutos'),
            ],
          ),
        ),
        RichText(
          text: TextSpan(children: [
            const TextSpan(text: 'Idade recomendada: '),
            TextSpan(
              text: '${ad.boardgame!.minAge}+',
              style: AppTextStyle.font16Bold,
            ),
          ]),
        ),
        RichText(
          text: TextSpan(
            text: 'Designer: ',
            children: [
              TextSpan(
                text: ad.boardgame!.designer,
                style: AppTextStyle.font16Bold,
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Artistas: ',
            children: [
              TextSpan(
                text: ad.boardgame!.artist,
                style: AppTextStyle.font16Bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

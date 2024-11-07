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

import '../../../../core/singletons/app_settings.dart';
import '../../../../get_it.dart';

class OwnerRating extends StatelessWidget {
  final String? owner;
  final int starts;

  const OwnerRating({
    super.key,
    required this.starts,
    this.owner,
  });

  bool get isDark => getIt<AppSettings>().isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(owner ?? ''),
        ),
        Text(
          '✸' * starts,
          style: TextStyle(
            color: isDark ? Colors.yellow : Colors.amber,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

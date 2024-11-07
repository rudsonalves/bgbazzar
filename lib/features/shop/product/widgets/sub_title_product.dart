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

import '../../../../core/theme/app_text_style.dart';

class SubTitleProduct extends StatelessWidget {
  final String subtile;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const SubTitleProduct({
    super.key,
    required this.subtile,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding != null ? padding! : const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        subtile,
        style: AppTextStyle.font16.copyWith(color: color),
      ),
    );
  }
}
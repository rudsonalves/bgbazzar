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
import '../edit_ad_controller.dart';
import 'horizontal_image_gallery.dart';

class ImagesListView extends StatelessWidget {
  final EditAdController ctrl;
  final bool validator;
  final Function(AdModel ad)? editAd;
  final Function(AdModel ad)? deleteAd;

  const ImagesListView({
    super.key,
    required this.ctrl,
    required this.validator,
    this.editAd,
    this.deleteAd,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ctrl.app.isDark
            ? colorScheme.onSecondary
            : colorScheme.primary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 120,
      child: ValueListenableBuilder(
        valueListenable: ctrl.imagesLength,
        builder: (context, length, _) => HotizontalImageGallery(
          length: length,
          images: ctrl.images,
          addImage: ctrl.addImage,
          removeImage: ctrl.removeImage,
        ),
      ),
    );
  }
}

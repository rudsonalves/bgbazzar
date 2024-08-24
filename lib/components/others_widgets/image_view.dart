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

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String image;
  final BoxFit? fit;

  const ImageView({
    super.key,
    required this.image,
    this.fit,
  });

  Widget displayImage(String showImage) {
    if (showImage.isEmpty) {
      return Image.asset(
        'assets/images/image_witout.png',
        fit: fit,
      );
    } else if (showImage.contains(RegExp(r'^http'))) {
      return CachedNetworkImage(
        imageUrl: showImage,
        fit: fit,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/image_not_found.png',
          fit: fit,
        ),
      );
    } else {
      return Image.file(
        File(showImage),
        fit: fit,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return displayImage(image.trim());
  }
}

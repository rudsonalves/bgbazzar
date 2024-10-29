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

import 'image_list_store.dart';

class ImageListController {
  late final ImageListStore store;
  final List<String> _images = [];

  List<String> get images => _images;

  void init(ImageListStore store) {
    this.store = store;
  }

  void setImages(List<String> images) {
    _images.clear();
    _images.addAll(images);
    store.setImagesLength(_images.length);
  }

  void addImage(String path) {
    _images.add(path);
    store.setImagesLength(_images.length);
  }

  void removeImage(int index) {
    final image = images[index];
    if (index < images.length) {
      if (image.contains(RegExp(r'^http'))) {
        _images.removeAt(index);
        store.setImagesLength(_images.length);
      } else {
        final file = File(image);
        _images.removeAt(index);
        store.setImagesLength(_images.length);
        file.delete();
      }
    }
  }
}

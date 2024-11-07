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

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../components/widgets/bottom_message.dart';
import 'photo_origin_bottom_sheet.dart';

const maxImages = 5;

class HotizontalImageGallery extends StatefulWidget {
  final List<String> images;
  final void Function(String path) addImage;
  final void Function(int index) removeImage;

  const HotizontalImageGallery({
    super.key,
    required this.images,
    required this.addImage,
    required this.removeImage,
  });

  @override
  State<HotizontalImageGallery> createState() => _HotizontalImageGalleryState();
}

class _HotizontalImageGalleryState extends State<HotizontalImageGallery> {
  Future<void> getFromCamera() async {
    Navigator.pop(context);
    if (Platform.isAndroid || Platform.isIOS) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      imageSelected(image);
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => const BottomMessage(
          title: 'Desculpe',
          message:
              'Esta funcionalidade não está implementada para este sistema.'
              ' Importe imagens diretamente do disco ("Galeria").',
        ),
      );
    }
  }

  Future<void> getFromGallery() async {
    Navigator.pop(context);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    imageSelected(image);
  }

  Future<void> imageSelected(XFile? image) async {
    final colorScheme = Theme.of(context).colorScheme;

    if (image == null) return;
    if (Platform.isLinux) {
      widget.addImage(image.path);
      return;
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cortar Imagem',
            toolbarColor: colorScheme.primary,
            toolbarWidgetColor: colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cortar Imagem',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir',
        ),
      ],
    );

    if (croppedFile != null) {
      widget.addImage(croppedFile.path);
    }
  }

  void _showImageEditDialog(int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final image = widget.images[index];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        backgroundColor: colorScheme.onSecondary,
        title: const Text('Image'),
        content: image.contains(RegExp(r'^http'))
            ? Image.network(image)
            : Image.file(File(image)),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.removeImage(index);
              Navigator.pop(context);
              setState(() {});
            },
            label: const Text('Remover'),
            icon: const Icon(Icons.delete),
          ),
          TextButton.icon(
            onPressed: Navigator.of(context).pop,
            label: const Text('Fechar'),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  void _showModelBottomImageSource() {
    showModalBottomSheet(
      context: context,
      builder: (context) => PhotoOriginBottomSheet(
        getFromCamera: getFromCamera,
        getFromGallery: getFromGallery,
      ),
    );
  }

  Image showImage(String url) {
    return url.contains(RegExp(r'http'))
        ? Image.network(url)
        : Image.file(File(url));
  }

  @override
  Widget build(BuildContext context) {
    int length = widget.images.length;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: length < maxImages ? length + 1 : maxImages,
      itemBuilder: (context, index) {
        if (index < length) {
          // Show image
          return Padding(
            padding: const EdgeInsets.only(right: 4),
            child: InkWell(
              onTap: () => _showImageEditDialog(index),
              child: SizedBox(
                child: showImage(widget.images[index]),
              ),
            ),
          );
        } else {
          // show add image button
          return Padding(
            padding: const EdgeInsets.all(2),
            child: SizedBox(
              width: 108,
              height: 108,
              child: IconButton.filledTonal(
                onPressed: _showModelBottomImageSource,
                icon: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Symbols.add_a_photo_rounded,
                      size: 65,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

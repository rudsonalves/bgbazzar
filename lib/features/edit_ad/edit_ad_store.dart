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
import '../../core/models/address.dart';
import '../../core/models/boardgame.dart';
import '../../core/utils/validators.dart';
import '../../core/state/state_store.dart';

class EditAdStore extends StateStore {
  late AdModel ad;

  final hidePhone = ValueNotifier<bool>(false);
  final errorName = ValueNotifier<String?>(null);
  final errorDescription = ValueNotifier<String?>(null);
  final errorAddress = ValueNotifier<String?>(null);
  final errorPrice = ValueNotifier<String?>(null);
  final errorImages = ValueNotifier<String?>(null);
  final updateImages = ValueNotifier<int>(0);
  final bgInfo = ValueNotifier<String?>(null);

  void startAd(AdModel? ad) {
    this.ad = ad ??
        AdModel(
          images: [],
          title: '',
          description: '',
          mechanicsIds: [],
          price: 0,
        );
  }

  @override
  void dispose() {
    super.dispose();
    hidePhone.dispose();
    errorName.dispose();
    errorDescription.dispose();
    errorAddress.dispose();
    errorPrice.dispose();
    errorImages.dispose();
    updateImages.dispose();
  }

  // setImages(List<String> images) {
  //   updateImages.value++;
  //   ad.images = List.from(images);
  //   _validateImages();
  // }

  addImage(String image) {
    if (ad.images.contains(image)) return;
    updateImages.value++;
    ad.images.add(image);
    _validateImages();
  }

  removeImage(String image) {
    if (!ad.images.contains(image)) return;
    updateImages.value++;
    ad.images.remove(image);
    _validateImages();
  }

  void _validateImages() {
    errorImages.value =
        ad.images.length > 2 ? null : 'Adicione ao menos duas imagens.';
  }

  void setName(String value) {
    ad.title = value;
    _validateName();
  }

  void _validateName() {
    errorName.value = Validator.name(ad.title);
  }

  void setDescription(String value) {
    ad.description = value;
    _validateDescription();
  }

  void _validateDescription() {
    errorDescription.value = ad.description.length > 12
        ? null
        : 'Dê uma descrição melhor sobre o estado do produto.';
  }

  void setAddress(AddressModel value) {
    ad.address = value;
    _validateAddress();
  }

  void _validateAddress() {
    errorAddress.value =
        ad.address != null ? null : 'Selecione um endereço valido.';
  }

  void setPrice(double value) {
    ad.price = value;
    _validatePrice();
  }

  void _validatePrice() {
    errorPrice.value = ad.price > 0 ? null : 'Preencha o valor de seu produto.';
  }

  void setMechanics(List<String> mechs) {
    ad.mechanicsIds = mechs;
  }

  void setHidePhone(bool value) {
    ad.hidePhone = value;
    hidePhone.value = value;
  }

  void setBGInfo(BoardgameModel bg) {
    ad.boardgame = bg;
    addImage(bg.image);
    bgInfo.value = ad.boardgame.toString();
  }

  // void setPublishedYear(int publishYear) {
  //   ad.publishedYear = publishYear;
  // }

  // void setMinPlayers(int minplayer) {
  //   ad.minPlayers = minplayer;
  // }

  // void setMaxPlayers(int maxplayers) {
  //   ad.maxPlayers = maxplayers;
  // }

  // void setMinPlayTime(int minplaytime) {
  //   ad.minPlayTime = minplaytime;
  // }

  // void setMaxPlayTime(int maxplaytime) {
  //   ad.maxPlayTime = maxplaytime;
  // }

  // void setAge(int age) {
  //   ad.age = age;
  // }

  // void setDesigner(String? designer) {
  //   ad.designer = designer;
  // }

  // void setArtist(String? artist) {
  //   ad.artist = artist;
  // }

  bool get isValid {
    _validateName();
    _validateDescription();
    _validateAddress();
    _validatePrice();
    _validateImages();

    return errorImages.value == null &&
        errorName.value == null &&
        errorDescription.value == null &&
        errorAddress.value == null &&
        errorPrice.value == null;
  }

  void resetStore() {
    errorName.value = null;
    errorDescription.value = null;
    errorAddress.value = null;
    errorPrice.value = null;
    errorImages.value = null;
  }
}

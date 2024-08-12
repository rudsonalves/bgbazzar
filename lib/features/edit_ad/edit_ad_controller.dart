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

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/models/ad.dart';
import '../../common/models/boardgame.dart';
import '../../common/models/mechanic.dart';
import '../../common/singletons/app_settings.dart';
import '../../common/singletons/current_user.dart';
import '../../components/custon_field_controllers/currency_text_controller.dart';
import '../../get_it.dart';
import '../../manager/bg_names_manager.dart';
import '../../manager/mechanics_manager.dart';
import '../../repository/parse_server/ad_repository.dart';
import 'edit_ad_state.dart';

class EditAdController extends ChangeNotifier {
  EditAdState _state = EditAdStateInitial();

  EditAdState get state => _state;

  final app = getIt<AppSettings>();
  final currentUser = getIt<CurrentUser>();
  final mechanicsManager = getIt<MechanicsManager>();
  final bgNamesManager = getIt<BgNamesManager>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  String? bggName;
  final descriptionController = TextEditingController();
  final mechanicsController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = CurrencyTextController();
  final hidePhone = ValueNotifier<bool>(false);

  AdModel ad = AdModel(
    images: [],
    title: '',
    description: '',
    mechanicsId: [],
    price: 0,
  );

  final _images = <String>[];
  final _imagesLength = ValueNotifier<int>(0);
  final List<int> _selectedMechIds = [];

  String _selectedAddressId = '';
  String get selectedAddressId => _selectedAddressId;
  ProductCondition _condition = ProductCondition.used;
  AdStatus _adStatus = AdStatus.pending;

  List<MechanicModel> get mechanics => mechanicsManager.mechanics;
  List<String> get mechanicsNames => mechanicsManager.mechanicsNames;
  ProductCondition get condition => _condition;
  AdStatus get adStatus => _adStatus;

  List<int> get selectedMechIds => _selectedMechIds;
  List<String> get selectedMachNames => mechanics
      .where((c) => _selectedMechIds.contains(c.id!))
      .map((c) => c.name)
      .toList();

  ValueNotifier<int> get imagesLength => _imagesLength;
  List<String> get images => _images;

  final _valit = ValueNotifier<bool?>(null);
  ValueNotifier<bool?> get valit => _valit;

  void init(AdModel? editAd) {
    if (editAd != null) {
      ad = editAd;
      nameController.text = editAd.title;
      descriptionController.text = editAd.description;
      hidePhone.value = editAd.hidePhone;
      priceController.currencyValue = editAd.price;
      setAdStatus(editAd.status);
      setMechanicsIds(editAd.mechanicsId);
      setSelectedAddress(editAd.address!.name);
      setImages(editAd.images);
      setCondition(editAd.condition);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    mechanicsController.dispose();
    addressController.dispose();
    priceController.dispose();
    _imagesLength.dispose();
    hidePhone.dispose();
    super.dispose();
  }

  void _changeState(EditAdState newState) {
    _state = newState;
    notifyListeners();
  }

  void addImage(String path) {
    _images.add(path);
    _imagesLength.value = _images.length;
  }

  void setImages(List<String> images) {
    _images.clear();
    _images.addAll(images);
    _imagesLength.value = _images.length;
  }

  void removeImage(int index) {
    final image = images[index];
    if (index < images.length) {
      if (image.contains(RegExp(r'^http'))) {
        _images.removeAt(index);
        _imagesLength.value = _images.length;
      } else {
        final file = File(image);
        _images.removeAt(index);
        _imagesLength.value = _images.length;
        file.delete();
      }
    }
  }

  void setBggInfo(BoardgameModel bg) {
    _changeState(EditAdStateLoading());
    setMechanicsIds(bg.mechanics);
    nameController.text = bg.name;
    ad.title = bg.name;
    ad.yearpublished = bg.publishYear;
    ad.minplayers = bg.minPlayers;
    ad.maxplayers = bg.maxPlayers;
    ad.minplaytime = bg.minTime;
    ad.maxplaytime = bg.maxTime;
    ad.age = bg.minAge;
    ad.designer = bg.designer;
    ad.artist = bg.artist;
    _changeState(EditAdStateSuccess());
  }

  void setMechanicsIds(List<int> mechIds) {
    _selectedMechIds.clear();
    _selectedMechIds.addAll(mechIds);
    mechanicsController.text = selectedMachNames.join(', ');
  }

  bool get formValit {
    _valit.value = formKey.currentState != null &&
        formKey.currentState!.validate() &&
        imagesLength.value > 0;
    return _valit.value!;
  }

  Future<AdModel?> updateAds(String id) async {
    if (!formValit) return null;
    try {
      _changeState(EditAdStateLoading());

      ad.id = id;
      ad.owner = currentUser.user!;
      ad.images = _images;
      ad.title = nameController.text;
      ad.description = descriptionController.text;
      ad.mechanicsId = _selectedMechIds;
      ad.address = currentUser.addresses
          .firstWhere((address) => address.id == _selectedAddressId);
      ad.price = priceController.currencyValue;
      ad.hidePhone = hidePhone.value;
      ad.condition = _condition;
      ad.status = _adStatus;

      await AdRepository.update(ad);
      _changeState(EditAdStateSuccess());
      return ad;
    } catch (err) {
      log(err.toString());
      _changeState(EditAdStateError());
      return null;
    }
  }

  Future<AdModel?> createAds() async {
    if (!formValit) return null;
    try {
      _changeState(EditAdStateLoading());

      ad.owner = currentUser.user!;
      ad.images = _images;
      ad.title = nameController.text;
      ad.description = descriptionController.text;
      ad.mechanicsId = _selectedMechIds;
      ad.address = currentUser.addresses
          .firstWhere((address) => address.id == _selectedAddressId);
      ad.price = priceController.currencyValue;
      ad.hidePhone = hidePhone.value;
      ad.condition = _condition;
      ad.status = _adStatus;

      await AdRepository.save(ad);
      _changeState(EditAdStateSuccess());
      return ad;
    } catch (err) {
      log(err.toString());
      _changeState(EditAdStateError());
      return null;
    }
  }

  void setCondition(ProductCondition newCondition) {
    _condition = newCondition;
  }

  void setAdStatus(AdStatus newStatus) {
    _adStatus = newStatus;
  }

  void setSelectedAddress(String addressName) {
    final addressNames = currentUser.addressNames;
    if (addressNames.contains(addressName)) {
      final address = currentUser.addressByName(addressName)!;
      addressController.text = address.addressString();
      _selectedAddressId = address.id!;
    }
  }

  void gotoSuccess() {
    _changeState(EditAdStateSuccess());
  }
}

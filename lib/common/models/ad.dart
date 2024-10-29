// ignore_for_file: public_member_api_docs, sort_constructors_first
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

import '/manager/mechanics_manager.dart';
import '../../get_it.dart';
import 'address.dart';
import 'boardgame.dart';
import 'user.dart';

enum AdStatus { pending, active, sold, deleted }

enum ProductCondition { all, used, sealed }

class AdModel {
  String? id;
  UserModel? owner;
  BoardgameModel? boardgame;
  String title;
  String description;
  bool hidePhone;
  double price;
  AdStatus status;
  List<String> mechanicsPSIds;
  AddressModel? address;
  List<String> images;
  ProductCondition condition;

  int? yearpublished;
  int? minplayers;
  int? maxplayers;
  int? minplaytime;
  int? maxplaytime;
  int? age;
  String? designer;
  String? artist;

  int views;
  DateTime createdAt;

  AdModel({
    this.id,
    this.owner,
    this.boardgame,
    required this.images,
    required this.title,
    required this.description,
    required this.mechanicsPSIds,
    this.address,
    required this.price,
    this.condition = ProductCondition.all,
    this.yearpublished,
    this.minplayers,
    this.maxplayers,
    this.minplaytime,
    this.maxplaytime,
    this.age,
    this.designer,
    this.artist,
    this.hidePhone = false,
    this.status = AdStatus.pending,
    this.views = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  String get mechanicsString {
    final mechManager = getIt<MechanicsManager>();
    return mechManager.mechanics
        .where((mec) => mechanicsPSIds.contains(mec.psId))
        .map((mec) => mec.name)
        .toList()
        .join(', ');
  }

  // static List<String> mechNamesToPSIds(String names) {
  //   final mechManager = getIt<MechanicsManager>();

  //   try {
  //     final listNames = names.split(', ');
  //     final List<String> mechIds = [];
  //     for (final mechName in listNames) {
  //       mechIds.add(mechManager.mechanics
  //           .firstWhere(
  //             (mec) => mec.name == mechName,
  //           )
  //           .name);
  //     }

  //     return mechIds;
  //   } catch (err) {
  //     log(err.toString());
  //     return [];
  //   }
  // }

  @override
  String toString() {
    return 'AdModel(id: $id,\n'
        ' owner: $owner,\n'
        ' boardgame: $boardgame,\n'
        ' title: $title,\n'
        ' description: $description,\n'
        ' hidePhone: $hidePhone,\n'
        ' price: $price,\n'
        ' status: $status,\n'
        ' mechanicsId: $mechanicsPSIds,\n'
        ' address: $address,\n'
        ' images: $images,\n'
        ' condition: $condition,\n'
        ' yearpublished: $yearpublished,\n'
        ' minplayers: $minplayers,\n'
        ' maxplayers: $maxplayers,\n'
        ' minplaytime: $minplaytime,\n'
        ' maxplaytime: $maxplaytime,\n'
        ' age: $age,\n'
        ' designer: $designer,\n'
        ' artist: $artist,\n'
        ' views: $views,\n'
        ' createdAt: $createdAt)';
  }

  AdModel copyWith({
    String? id,
    UserModel? owner,
    BoardgameModel? boardgame,
    String? title,
    String? description,
    bool? hidePhone,
    double? price,
    AdStatus? status,
    List<String>? mechanicsId,
    AddressModel? address,
    List<String>? images,
    ProductCondition? condition,
    int? yearpublished,
    int? minplayers,
    int? maxplayers,
    int? minplaytime,
    int? maxplaytime,
    int? age,
    String? designer,
    String? artist,
    int? views,
    DateTime? createdAt,
  }) {
    return AdModel(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      boardgame: boardgame ?? this.boardgame,
      title: title ?? this.title,
      description: description ?? this.description,
      hidePhone: hidePhone ?? this.hidePhone,
      price: price ?? this.price,
      status: status ?? this.status,
      mechanicsPSIds: mechanicsId ?? this.mechanicsPSIds,
      address: address ?? this.address,
      images: images ?? this.images,
      condition: condition ?? this.condition,
      yearpublished: yearpublished ?? this.yearpublished,
      minplayers: minplayers ?? this.minplayers,
      maxplayers: maxplayers ?? this.maxplayers,
      minplaytime: minplaytime ?? this.minplaytime,
      maxplaytime: maxplaytime ?? this.maxplaytime,
      age: age ?? this.age,
      designer: designer ?? this.designer,
      artist: artist ?? this.artist,
      views: views ?? this.views,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

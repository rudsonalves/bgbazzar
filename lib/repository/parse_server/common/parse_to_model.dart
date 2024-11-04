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

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '/common/models/mechanic.dart';
import '/common/models/address.dart';
import '/common/models/ad.dart';
import '/common/models/bg_name.dart';
import '/common/models/boardgame.dart';
import '/common/models/favorite.dart';
import '/common/models/user.dart';
import 'constants.dart';

extension ParseObjectExtensions on ParseObject {
  void setNonNull<T>(String key, T? value) {
    if (value != null) {
      set<T>(key, value);
    }
  }
}

/// This class provides static methods to convert Parse objects to application
/// models.
class ParseToModel {
  ParseToModel._();

  /// Converts a ParseUser object to a UserModel.
  ///
  /// [parse] - The ParseUser object to convert.
  /// Returns a UserModel representing the ParseUser.
  static UserModel user(ParseUser parse) {
    return UserModel(
      id: parse.objectId,
      name: parse.get<String>(keyUserNickname),
      email: parse.username!,
      phone: parse.get<String>(keyUserPhone),
      userType: UserType.values[parse.get<int>(keyUserType)!],
      createdAt: parse.createdAt,
    );
  }

  /// Converts a ParseObject representing an address to an AddressModel.
  ///
  /// [parse] - The ParseObject to convert.
  /// Returns an AddressModel representing the ParseObject.
  static AddressModel address(ParseObject parse) {
    return AddressModel(
      id: parse.objectId,
      name: parse.get<String>(keyAddressName)!,
      zipCode: parse.get<String>(keyAddressZipCode)!,
      userId: parse.get<ParseUser>(keyAddressOwner)!.objectId!,
      street: parse.get<String>(keyAddressStreet)!,
      number: parse.get<String>(keyAddressNumber)!,
      complement: parse.get<String?>(keyAddressComplement),
      neighborhood: parse.get<String>(keyAddressNeighborhood)!,
      state: parse.get<String>(keyAddressState)!,
      city: parse.get<String>(keyAddressCity)!,
      createdAt: parse.get<DateTime>(keyAddressCreatedAt)!,
    );
  }

  /// Converts a ParseObject representing an advertisement to an AdModel.
  ///
  /// [parse] - The ParseObject to convert.
  /// Returns an AdModel representing the ParseObject if the address and
  /// user are not null, otherwise returns null.
  static AdModel? ad(ParseObject parse) {
    final parseAddress = parse.get<ParseObject?>(keyAdAddress);
    if (parseAddress == null) return null;
    AddressModel? address = ParseToModel.address(parseAddress);

    final parseUser = parse.get<ParseUser?>(keyAdOwner);
    if (parseUser == null) return null;
    final user = ParseToModel.user(parseUser);

    final mechs = parse.get<List<dynamic>>(keyAdMechanics) ?? [];

    return AdModel(
      id: parse.objectId,
      owner: user,
      title: parse.get<String>(keyAdTitle)!,
      description: parse.get<String>(keyAdDescription)!,
      price: parse.get<num>(keyAdPrice)!.toDouble(),
      hidePhone: parse.get<bool>(keyAdHidePhone)!,
      images: (parse.get<List<dynamic>>(keyAdImages) as List<dynamic>)
          .map((item) => (item as ParseFile).url!)
          .toList(),
      mechanicsIds: mechs.map((element) => element as String).toList(),
      address: address,
      status: AdStatus.values
          .firstWhere((s) => s.index == parse.get<int>(keyAdStatus)!),
      condition: ProductCondition.values
          .firstWhere((c) => c.index == parse.get<int>(keyAdCondition)!),
      views: parse.get<int>(keyAdViews, defaultValue: 0)!,
      createdAt: parse.get<DateTime>(keyAdCreatedAt)!,
    );
  }

  static FavoriteModel favorite(ParseObject parse) {
    final adMap = parse.get(keyFavoriteAd);

    return FavoriteModel(
      id: parse.objectId,
      adId: adMap['objectId'],
    );
  }

  static BoardgameModel boardgameModel(ParseObject parse) {
    final mechs = parse.get<List<dynamic>>(keyBgMechanics)!;

    return BoardgameModel(
      id: parse.objectId,
      name: parse.get<String>(keyBgName)!,
      image: parse.get<ParseFile>(keyBgImage)!.url!,
      publishYear: parse.get<int>(keyBgPublishYear)!,
      minPlayers: parse.get<int>(keyBgMinPlayers)!,
      maxPlayers: parse.get<int>(keyBgMaxPlayers)!,
      minTime: parse.get<int>(keyBgMinTime)!,
      maxTime: parse.get<int>(keyBgMaxTime)!,
      minAge: parse.get<int>(keyBgMinAge)!,
      designer: parse.get<String?>(keyBgDesigner)!,
      artist: parse.get<String?>(keyBgArtist)!,
      description: parse.get<String?>(keyBgDescription)!,
      mechsPsIds: mechs.map((item) => item as String).toList(),
    );
  }

  static BGNameModel bgNameModel(ParseObject parse) {
    String name = parse.get<String>(keyBgName)!;
    int year = parse.get<int>(keyBgPublishYear)!;

    return BGNameModel(
      id: parse.objectId!,
      name: '$name ($year)',
    );
  }

  static MechanicModel mechanic(ParseObject parse) {
    return MechanicModel(
      id: parse.objectId,
      name: parse.get<String>(keyMechName)!,
      description: parse.get<String>(keyMechDescription)!,
    );
  }
}

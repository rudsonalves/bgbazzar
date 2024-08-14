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

import 'package:path/path.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../common/models/ad.dart';
import '../../common/models/filter.dart';
import '../../common/models/user.dart';
import 'common/constants.dart';
import 'common/parse_to_model.dart';

/// This class provides methods to interact with the Parse Server
/// to retrieve and save advertisements.
class PSAdRepository {
  static Future<void> moveAdsAddressTo(
    List<String> adsIdList,
    String moveToId,
  ) async {
    try {
      final parseAddress = ParseObject(keyAddressTable)..objectId = moveToId;
      for (String id in adsIdList) {
        final parseAd = ParseObject(keyAdTable)
          ..objectId = id
          ..set(keyAdAddress, parseAddress.toPointer());

        final response = await parseAd.update();

        if (!response.success) {
          throw Exception(response.error ?? 'update ad table error');
        }
      }
    } catch (err) {
      final message = 'AdRepository.getMyAds: $err';
      log(message);
      throw Exception(message);
    }
  }

  static Future<List<String>> adsInAddress(String addressId) async {
    final List<String> adsId = [];
    try {
      final query = QueryBuilder<ParseObject>(ParseObject(keyAdTable));
      final parseAddress = ParseObject(keyAddressTable)..objectId = addressId;

      query.whereEqualTo(keyAdAddress, parseAddress.toPointer());

      final response = await query.query();

      if (!response.success) {
        return [];
      }

      for (final ParseObject parse in response.results!) {
        adsId.add(parse.objectId as String);
      }

      return adsId;
    } catch (err) {
      final message = 'AddressRepository.delete: $err';
      log(message);
      return [];
    }
  }

  static Future<bool> updateStatus(AdModel ad) async {
    try {
      final parse = ParseObject(keyAdTable)
        ..objectId = ad.id!
        ..set(keyAdStatus, ad.status.index);

      final response = await parse.update();

      if (!response.success) {
        throw Exception(response.error ?? 'update ad table error');
      }

      return true;
    } catch (err) {
      final message = 'AdRepository.getMyAds: $err';
      log(message);
      return false;
    }
  }

  /// Fetches a list of advertisements from an user.
  ///
  /// [user] - The user to apply to the search.
  /// Returns a list of `AdvertModel` if the query is successful, otherwise
  /// returns `null`.
  static Future<List<AdModel>?> getMyAds(UserModel usr, int status) async {
    try {
      final query = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('current user not found. Make login again.');
      }

      query
        ..setLimit(100)
        ..whereEqualTo(keyAdOwner, parseUser.toPointer())
        ..whereEqualTo(keyAdStatus, status)
        ..orderByDescending(keyAdCreatedAt)
        ..includeObject([keyAdOwner, keyAdAddress]);

      final response = await query.query();
      if (!response.success) {
        throw Exception(response.error.toString());
      }

      if (response.results == null) {
        throw Exception('search return a empty list');
      }

      List<AdModel> ads = [];
      for (final ParseObject p in response.results!) {
        final adModel = ParseToModel.ad(p);
        if (adModel != null) ads.add(adModel);
      }

      return ads;
    } catch (err) {
      final message = 'AdRepository.getMyAds: $err';
      log(message);
      return null;
    }
  }

  /// Fetches a list of advertisements from the Parse Server based on the
  /// provided filters and search string.
  ///
  /// [filter] - The filter model to apply to the search.
  /// [search] - The search string to filter advertisements by title.
  /// [page] - The page number to retrieve, used for pagination.
  /// Returns a list of `AdModel` if the query is successful, otherwise
  /// returns `null`.
  static Future<List<AdModel>?> get({
    required FilterModel filter,
    required String search,
    int page = 0,
  }) async {
    final query = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    try {
      query.setAmountToSkip(page * maxAdsPerList);
      query.setLimit(maxAdsPerList);

      query.includeObject([keyAdOwner, keyAdAddress]);

      query.whereEqualTo(keyAdStatus, AdStatus.active.index);

      // Filter by search String
      if (search.trim().isNotEmpty) {
        query.whereContains(
          keyAdTitle,
          search.trim(),
          caseSensitive: false,
        );
      }

      // Filter by machanics
      if (filter.mechanicsId.isNotEmpty) {
        for (final mechId in filter.mechanicsId) {
          final mechParse = ParseObject(keyMechanicTable)
            ..set(keyMechanicId, mechId);
          query.whereEqualTo(keyAdMechanics, mechParse.toPointer());
        }
      }

      switch (filter.sortBy) {
        case SortOrder.price:
          // Filter by price
          query.orderByAscending(keyAdPrice);
          break;
        case SortOrder.date:
        default:
          // Filter by date
          query.orderByDescending(keyAdCreatedAt);
      }

      // Filter minPrice
      if (filter.minPrice > 0) {
        query.whereGreaterThanOrEqualsTo(keyAdPrice, filter.minPrice);
      }

      // Filter maxPrice
      if (filter.maxPrice > 0) {
        query.whereLessThanOrEqualTo(keyAdPrice, filter.maxPrice);
      }

      // Filter by product condition
      if (filter.condition != ProductCondition.all) {
        query.whereEqualTo(keyAdCondition, filter.condition.index);
      }

      final response = await query.query();
      if (!response.success) {
        throw Exception(response.error.toString());
      }

      if (response.results == null) {
        return [];
      }

      List<AdModel> ads = [];
      for (final ParseObject ad in response.results!) {
        final adModel = ParseToModel.ad(ad);
        if (adModel != null) ads.add(adModel);
      }

      return ads;
    } catch (err) {
      final message = 'AdRepository.get: $err';
      log(message);
      return null;
    }
  }

  /// Saves an advertisement to the Parse Server.
  ///
  /// [ad] - The advertisement model to save.
  /// Returns the saved `AdModel` if successful, otherwise throws an
  /// exception.
  static Future<AdModel?> save(AdModel ad) async {
    try {
      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('Current user access error');
      }

      List<ParseFile> parseImages = await _saveImages(ad.images, parseUser);

      final parseAddress = ParseObject(keyAddressTable);
      parseAddress.objectId = ad.address!.id;

      final parseAd = ParseObject(keyAdTable);
      if (ad.id != null) {
        parseAd.objectId = ad.id;
      }

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);

      parseAd
        ..setACL(parseAcl)
        ..set<ParseUser>(keyAdOwner, parseUser)
        ..set<String>(keyAdTitle, ad.title)
        ..set<String>(keyAdDescription, ad.description)
        ..set<bool>(keyAdHidePhone, ad.hidePhone)
        ..set<double>(keyAdPrice, ad.price)
        ..set<int>(keyAdStatus, ad.status.index)
        ..set<int>(keyAdCondition, ad.condition.index)
        ..set<int?>(keyAdYearpublished, ad.yearpublished)
        ..set<int?>(keyAdMinplayers, ad.minplayers)
        ..set<int?>(keyAdMaxplayers, ad.maxplayers)
        ..set<int?>(keyAdMinplaytime, ad.minplaytime)
        ..set<int?>(keyAdMaxplaytime, ad.maxplaytime)
        ..set<int?>(keyAdAge, ad.age)
        ..set<String?>(keyAdDesigner, ad.designer)
        ..set<String?>(keyAdArtist, ad.artist)
        ..set<ParseObject>(keyAdAddress, parseAddress)
        ..set<List<ParseFile>>(keyAdImages, parseImages)
        ..set<List<int>>(keyAdMechanics, ad.mechanicsId);

      final response = await parseAd.save();
      if (!response.success) {
        if (response.count > 0) {
          for (final item in response.results!) {
            log('>> ${item.toString()}');
          }
        } else {
          log('parseAd.save error: ${response.error?.message}');
        }
        throw Exception(response.error);
      }

      return ParseToModel.ad(parseAd);
    } catch (err) {
      final message = 'AdRepository.save: $err';
      log(message);
      rethrow;
    }
  }

  static Future<AdModel?> update(AdModel ad) async {
    try {
      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('Current user access error');
      }

      List<ParseFile> parseImages = await _saveImages(ad.images, parseUser);

      final parseAddress = ParseObject(keyAddressTable);
      parseAddress.objectId = ad.address!.id;

      if (ad.id == null) {
        throw Exception('Ad ID cannot be null for update');
      }

      final parseAd = ParseObject(keyAdTable)..objectId = ad.id!;

      parseAd
        ..set<String>(keyAdTitle, ad.title)
        ..set<String>(keyAdDescription, ad.description)
        ..set<bool>(keyAdHidePhone, ad.hidePhone)
        ..set<double>(keyAdPrice, ad.price)
        ..set<int>(keyAdStatus, ad.status.index)
        ..set<int>(keyAdCondition, ad.condition.index)
        ..set<int?>(keyAdYearpublished, ad.yearpublished)
        ..set<int?>(keyAdMinplayers, ad.minplayers)
        ..set<int?>(keyAdMaxplayers, ad.maxplayers)
        ..set<int?>(keyAdMinplaytime, ad.minplaytime)
        ..set<int?>(keyAdMaxplaytime, ad.maxplaytime)
        ..set<int?>(keyAdAge, ad.age)
        ..set<String?>(keyAdDesigner, ad.designer)
        ..set<String?>(keyAdArtist, ad.artist)
        ..set<ParseObject>(keyAdAddress, parseAddress)
        ..set<List<ParseFile>>(keyAdImages, parseImages)
        ..set<List<int>>(keyAdMechanics, ad.mechanicsId);

      final response = await parseAd.update();
      if (!response.success) {
        if (response.count > 0) {
          for (final item in response.results!) {
            log('>> ${item.toString()}');
          }
        } else {
          log('parseAd.update error: ${response.error?.message}');
        }
        throw Exception(response.error);
      }

      return ad;
    } catch (err) {
      final message = 'AdRepository.update: $err';
      log(message);
      rethrow;
    }
  }

  /// Saves the images to the Parse Server.
  ///
  /// [imagesPaths] - The list of image paths to save.
  /// [parseUser] - The current Parse user.
  /// Returns a list of `ParseFile` representing the saved images.
  /// Throws an exception if the save operation fails.
  static Future<List<ParseFile>> _saveImages(
    List<String> imagesPaths,
    ParseUser parseUser,
  ) async {
    final parseImages = <ParseFile>[];

    try {
      for (final path in imagesPaths) {
        if (!path.contains(RegExp(r'http'))) {
          final file = File(path);
          final parseFile = ParseFile(file, name: basename(path));

          final acl = ParseACL(owner: parseUser);
          acl.setPublicReadAccess(allowed: true);
          acl.setPublicWriteAccess(allowed: false);

          parseFile.setACL(acl);

          final response = await parseFile.save();
          if (!response.success) {
            log('Error saving file: ${response.error}');
            throw Exception(response.error);
          }

          if (parseFile.url == null) {
            throw Exception('failed to get URL after saving the file');
          }

          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null, name: basename(path), url: path);
          parseImages.add(parseFile);
        }
      }

      return parseImages;
    } catch (err) {
      log('exception in _saveImages: $err');
      rethrow;
    }
  }

  static Future<void> delete(String ad) async {
    try {
      final parse = ParseObject(keyAdTable)..objectId = ad;

      final response = await parse.delete();
      if (!response.success) {
        throw Exception(response.error ?? 'delete ad table error');
      }
      return;
    } catch (err) {
      final message = 'AdRepository.delete: $err';
      log(message);
    }
  }
}

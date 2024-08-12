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

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../common/models/address.dart';
import 'common/constants.dart';
import 'common/parse_to_model.dart';

/// This class provides methods to interact with the Parse Server
/// to manage addresses associated with the user.
class AddressRepository {
  /// Saves an address to the Parse Server.
  ///
  /// [address] - The address model to save.
  /// Returns the saved `AddressModel` if successful, otherwise throws an
  /// exception.
  static Future<AddressModel?> save(AddressModel address) async {
    try {
      final parseAddress = ParseObject(keyAddressTable);

      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('current user not found. Make a login');
      }

      if (address.id != null) {
        parseAddress.objectId = address.id;
      }

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);

      parseAddress
        ..set<ParseUser>(keyAddressOwner, parseUser)
        ..set<String>(keyAddressName, address.name)
        ..set<String>(keyAddressZipCode, address.zipCode)
        ..set<String>(keyAddressStreet, address.street)
        ..set<String>(keyAddressNumber, address.number)
        ..set<String?>(keyAddressComplement, address.complement)
        ..set<String>(keyAddressNeighborhood, address.neighborhood)
        ..set<String>(keyAddressState, address.state)
        ..set<String>(keyAddressCity, address.city)
        ..setACL(parseAcl);

      final response = await parseAddress.save();
      if (!response.success) {
        log('parseAddress.save error');
        throw Exception(response.error.toString());
      }

      return ParseToModel.address(parseAddress);
    } catch (err) {
      final message = 'AddressRepository.save: $err';
      log(message);
      throw Exception(message);
    }
  }

  /// Deletes an address from the Parse Server.
  ///
  /// [addressId] - The address model to delete.
  /// Returns `true` if successful, otherwise returns `false`.
  static Future<bool> delete(String addressId) async {
    try {
      final parseAddress = ParseObject(keyAddressTable);
      parseAddress.objectId = addressId;

      final response = await parseAddress.delete();
      if (!response.success) {
        throw Exception(response.error?.message ?? 'unknown error');
      }
      return true;
    } catch (err) {
      final message = 'AddressRepository.delete: $err';
      log(message);
      throw Exception(message);
    }
  }

  /// Fetches the list of addresses associated with the current user.
  ///
  /// [userId] - The ID of the user whose addresses are to be fetched.
  /// Returns a list of `AddressModel` if successful, otherwise throws an
  /// exception.
  static Future<List<AddressModel>?> getUserAddresses(String userId) async {
    try {
      List<AddressModel>? addresses;

      final parseAddress = ParseObject(keyAddressTable);

      final parseUser = await ParseUser.currentUser() as ParseUser?;
      if (parseUser == null) {
        throw Exception('current user not found. Make login again.');
      }

      final queryBuilder = QueryBuilder<ParseObject>(parseAddress)
        ..whereEqualTo(keyAddressOwner, parseUser.toPointer());

      final response = await queryBuilder.query();
      if (!response.success) {
        throw Exception(response.error);
      }

      if (response.results == null || response.results!.isEmpty) return [];
      addresses = response.results!
          .map((parse) => ParseToModel.address(parse as ParseObject))
          .toList();

      return addresses;
    } catch (err) {
      final message = 'AddressRepository.getUserAddresses: $err';
      log(message);
      throw Exception(err);
    }
  }
}

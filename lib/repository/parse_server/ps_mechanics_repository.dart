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

import '../../common/abstracts/data_result.dart';
import '../../common/models/mechanic.dart';
import '../interfaces/i_mechanic_repository.dart';
import 'common/constants.dart';
import 'common/parse_to_model.dart';

class PSMechanicsRepository implements IMechanicRepository {
  @override
  Future<DataResult<MechanicModel>> add(MechanicModel mech) async {
    try {
      final parseUser = await _parseCurrentUser();
      final parseAcl = _createDefaultAcl(parseUser);

      // Prepares a ParseObject representing the new mechanic for saving
      final parseMech = _prepareMechForSaveOrUpdate(
        mech: mech,
        parseAcl: parseAcl,
      );

      // Save the ParseObject to the Parse server
      final response = await parseMech.save();
      if (!response.success) {
        throw Exception(response.error?.message ?? 'unknow error.');
      }

      // Converts the ParseObject back to a MechanicModel to return
      return DataResult.success(ParseToModel.mechanic(parseMech));
    } catch (err) {
      return _handleError('add', err);
    }
  }

  @override
  Future<DataResult<MechanicModel>> update(MechanicModel mech) async {
    try {
      final parseUser = await _parseCurrentUser();
      final parseAcl = _createDefaultAcl(parseUser);

      // Prepares a ParseObject representing the new mechanic for saving
      final parse = _prepareMechForSaveOrUpdate(
        mech: mech,
        parseAcl: parseAcl,
      );

      // Update the ParseObject to the Parse server
      final response = await parse.update();
      if (!response.success) {
        throw MechanicRepositoryException(
            response.error?.message ?? 'Failed to save ad.');
      }

      // Converts the ParseObject back to a MechanicModel to return
      return DataResult.success(ParseToModel.mechanic(parse));
    } catch (err) {
      return _handleError('update', err);
    }
  }

  @override
  Future<DataResult<List<MechanicModel>>> getAll() async {
    final query = QueryBuilder<ParseObject>(ParseObject(keyMechTable));

    try {
      // Executes the query to retrieve all mechanics
      final response = await query.query();

      // Checks if the query was successful and throws an error if not
      if (!response.success) {
        throw MechanicRepositoryException(
            response.error?.message ?? 'Failed to save ad.');
      }

      // Maps the results to a list of MechanicModel objects
      final List<MechanicModel> mechs = response.results
              ?.map((parse) => ParseToModel.mechanic(parse))
              .toList() ??
          [];

      return DataResult.success(mechs);
    } catch (err) {
      return _handleError('getAll', err);
    }
  }

  @override
  Future<DataResult<MechanicModel>> get(String psId) async {
    try {
      // Creates a ParseObject representing the mechanics table and retrieves
      // the object by ID
      final parse = ParseObject(keyMechTable);
      final response = await parse.getObject(psId);

      // Checks if the query was successful and throws an error if not
      if (!response.success) {
        throw MechanicRepositoryException(
            response.error?.message ?? 'register not found.');
      }

      // Checks if the response contains results, throws error if no record is
      // found
      if (response.results == null) {
        throw MechanicRepositoryException('not found mech.id: $psId');
      }

      // Converts the retrieved ParseObject to a MechanicModel instance
      final MechanicModel mechanic = ParseToModel.mechanic(
        response.results!.first as ParseObject,
      );

      return DataResult.success(mechanic);
    } catch (err) {
      return _handleError('getById', err);
    }
  }

  @override
  Future<DataResult<List<String>>> getIds() async {
    final query = QueryBuilder<ParseObject>(ParseObject(keyMechTable));

    try {
      // Restrict the query to return only the objectId key for each record
      query.keysToReturn([keyMechObjectId]);

      // Execute the query to fetch the object IDs
      final response = await query.query();

      // Checks if the query was successful, throws an error if not
      if (!response.success) {
        throw MechanicRepositoryException(
            response.error?.message ?? 'register not found.');
      }

      // Maps the query results to a list of object IDs (String)
      final List<String> mechs = response.results
              ?.map((parse) => (parse as ParseObject).objectId!)
              .toList() ??
          [];

      return DataResult.success(mechs);
    } catch (err) {
      return _handleError('getIds', err);
    }
  }

  /// Prepares a ParseObject representing a mechanic for save or update
  /// operations.
  ///
  /// This method takes a [MechanicModel] and converts it into a [ParseObject]
  /// that can be saved or updated in the Parse server.
  ///
  /// - If the [mech] contains a `psId`, the method assumes it is an update and
  ///   assigns that `objectId` to the ParseObject, indicating that it already
  ///   exists in the server.
  /// - If no `psId` is provided, the method creates a new ParseObject, assuming
  ///   it is for a new mechanic.
  ///
  /// Parameters:
  /// - [mech]: The mechanic model containing all the data that needs to be
  ///   persisted.
  /// - [parseAcl]: (Optional) A ParseACL object that will be assigned to the
  ///   ParseObject.
  ///   If provided, this will define the permissions for the object.
  ///
  /// Returns:
  /// A [ParseObject] configured with the mechanic information from [mech] that is
  /// ready to be saved or updated on the server.
  ParseObject _prepareMechForSaveOrUpdate({
    required MechanicModel mech,
    ParseACL? parseAcl,
  }) {
    final parseMech = mech.psId == null
        ? ParseObject(keyMechanicTable)
        : ParseObject(keyMechanicTable)
      ..objectId = mech.psId!;

    if (parseAcl != null) {
      parseMech.setACL(parseAcl);
    }

    parseMech
      ..set<String>(keyMechName, mech.name)
      ..set<String>(keyMechDescription, mech.description ?? '');

    return parseMech;
  }

  /// Creates a default ACL (Access Control List) for an object.
  ///
  /// The default ACL allows public read access but restricts write access to
  /// only the [owner]. This is generally used to protect the integrity of data
  /// while allowing other users to view it.
  ///
  /// Parameters:
  /// - [owner]: The [ParseUser] who will be set as the owner of the ACL, and
  ///   thus the one who will have full write permissions to the object.
  ///
  /// Returns:
  /// A [ParseACL] instance with permissions set for public read access and
  /// write access restricted to the owner.
  ParseACL _createDefaultAcl(ParseUser owner) {
    return ParseACL(owner: owner)
      ..setPublicReadAccess(allowed: true)
      ..setPublicWriteAccess(allowed: false);
  }

  /// Fetches the current logged-in user from Parse Server.
  ///
  /// This method attempts to get the current user that is authenticated
  /// in the Parse server. If no user is logged in, it throws a
  /// [MechanicRepositoryException].
  ///
  /// Throws:
  /// - [MechanicRepositoryException]: If there is no current user logged in.
  ///
  /// Returns:
  /// A [ParseUser] representing the current logged-in user.
  Future<ParseUser> _parseCurrentUser() async {
    final parseUser = await ParseUser.currentUser() as ParseUser?;
    if (parseUser == null) {
      throw MechanicRepositoryException('Current user access error');
    }
    return parseUser;
  }

  /// Handles errors by logging and wrapping them in a [DataResult] failure
  /// response.
  ///
  /// This method takes the name of the method where the error occurred and the
  /// actual error object.
  /// It logs a detailed error message and returns a failure wrapped in
  /// [DataResult].
  ///
  /// Parameters:
  /// - [method]: The name of the method where the error occurred.
  /// - [error]: The error object that describes what went wrong.
  ///
  /// Returns:
  /// A [DataResult.failure] with a [GenericFailure] that includes a detailed
  /// message.
  DataResult<T> _handleError<T>(String method, Object error) {
    final fullMessage = 'MechanicsRepository.$method: $error';
    log(fullMessage);
    return DataResult.failure(GenericFailure(message: fullMessage));
  }
}

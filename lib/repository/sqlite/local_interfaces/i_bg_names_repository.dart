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

import '../../../common/models/bg_name.dart';

/// A repository class for handling operations related to board game names using
/// SQLite.
///
/// This class implements the [IBgNamesRepository] interface and provides
/// methods for adding, updating, and retrieving board game names from a SQLite
/// database.
/// It interacts with a store (`BGNamesStore`) which performs the actual
/// database operations.
abstract class IBgNamesRepository {
  /// Retrieves all board game names from the SQLite database.
  ///
  /// This method attempts to get the list of all board game names using
  /// `BGNamesStore.get`.
  /// If no data is found, it returns an empty list.
  /// Throws an [Exception] if there is any error during the retrieval.
  ///
  /// Returns:
  /// - A [Future] containing a list of [BGNameModel] objects if successful.
  /// - Throws an exception if an error occurs during retrieval.
  Future<List<BGNameModel>> get();

  /// Adds a new board game name to the SQLite database.
  ///
  /// This method takes a [BGNameModel] object, converts it to a map,
  /// and inserts it into the database using `BGNamesStore.add`.
  /// If the insertion returns an ID less than zero, it throws an exception.
  /// Throws an [Exception] if there is an error during the add operation.
  ///
  /// Parameters:
  /// - [bg]: The [BGNameModel] to be added to the database.
  ///
  /// Returns:
  /// - A [Future] containing the added [BGNameModel] with the assigned ID.
  Future<BGNameModel> add(BGNameModel bg);

  /// Updates an existing board game name in the SQLite database.
  ///
  /// This method takes a [BGNameModel] object, converts it to a map, and
  /// updates the corresponding record in the database using
  /// `BGNamesStore.update`.
  /// Throws an [Exception] if there is an error during the update operation.
  ///
  /// Parameters:
  /// - [bg]: The [BGNameModel] to be updated in the database.
  ///
  /// Returns:
  /// - A [Future] containing the number of affected rows.
  Future<int> update(BGNameModel bg);
}

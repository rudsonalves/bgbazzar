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

import '/core/models/bag_item.dart';
import '/core/abstracts/data_result.dart';

abstract class ILocalBagItemRepository {
  Future<void> initialize();
  Future<DataResult<List<BagItemModel>>> getAll();
  Future<DataResult<BagItemModel>> add(BagItemModel bag);
  Future<DataResult<int>> update(BagItemModel bag);
  Future<DataResult<void>> delete(int bagId);
  Future<DataResult<void>> resetDatabase();
  Future<DataResult<void>> cleanDatabase();
}

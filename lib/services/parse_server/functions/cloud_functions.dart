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

class CloudFunctions {
  CloudFunctions._();

  static Future<void> assignUserToRoleCloud(
      String userId, String roleName) async {
    final response = await ParseCloudFunction('addUserToRole').execute(
      parameters: {'userId': userId, 'roleName': roleName},
    );

    if (!response.success) {
      throw Exception(
          'Failed to assign user to role "$roleName": ${response.error?.message ?? 'Unknown error'}');
    }
  }
}

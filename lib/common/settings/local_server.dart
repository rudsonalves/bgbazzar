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

import 'package:flutter_dotenv/flutter_dotenv.dart';

const bool isLocalServer = false;

class LocalServer {
  // parse serve declarations
  static String get keyApplicationId => isLocalServer
      ? (dotenv.env['APPLICATION_ID_LOCAL'] ?? '')
      : (dotenv.env['APPLICATION_ID'] ?? '');
  static String get keyClientKey => isLocalServer
      ? (dotenv.env['CLIENT_KEY_LOCAL'] ?? '')
      : (dotenv.env['CLIENT_KEY'] ?? '');
  static String get keyParseServerUrl => isLocalServer
      ? (dotenv.env['PARSE_SERVER_URL_LOCAL'] ?? '')
      : (dotenv.env['PARSE_SERVER_URL'] ?? '');
  static String get keyParseServerImageUrl => isLocalServer
      ? (dotenv.env['PARSE_SERVER_IMAGE_URL_LOCAL'] ?? '')
      : (dotenv.env['PARSE_SERVER_IMAGE_URL'] ?? '');
}

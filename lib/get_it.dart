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

import 'package:get_it/get_it.dart';

import 'repository/share_preferences/app_share_preferences_repository.dart';
import 'repository/share_preferences/i_app_preferences_repository.dart';
import 'common/singletons/app_settings.dart';
import 'common/singletons/current_user.dart';
import 'common/singletons/search_filter.dart';
import 'common/singletons/search_history.dart';
import 'manager/address_manager.dart';
import 'manager/boardgames_manager.dart';
import 'manager/favorites_manager.dart';
import 'manager/mechanics_manager.dart';
import 'repository/parse_server/interfaces/i_ad_repository.dart';
import 'repository/parse_server/interfaces/i_address_repository.dart';
import 'repository/parse_server/interfaces/i_boardgame_repository.dart';
import 'repository/parse_server/interfaces/i_favorite_repository.dart';
import 'repository/parse_server/interfaces/i_mechanic_repository.dart';
import 'repository/parse_server/interfaces/i_user_repository.dart';
import 'repository/parse_server/ps_address_repository.dart';
import 'repository/parse_server/ps_boardgame_repository.dart';
import '/repository/parse_server/ps_ad_repository.dart';
import 'repository/parse_server/ps_favorite_repository.dart';
import 'repository/parse_server/ps_mechanics_repository.dart';
import 'repository/parse_server/ps_user_repository.dart';
import 'repository/sqlite/bg_names_repository.dart';
import 'repository/sqlite/interfaces/i_bg_names_repository.dart';
import 'repository/sqlite/interfaces/i_local_mechanic_repository.dart';
import 'repository/sqlite/mechanic_repository.dart';
import 'services/parse_server_server.dart';
import 'store/database/database_manager.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  try {
    // Singletons
    getIt.registerSingleton<IAppPreferencesRepository>(
        AppSharePreferencesRepository());
    getIt.registerSingleton<AppSettings>(AppSettings());

    // Lazy Singletons
    getIt.registerLazySingleton<ParseServerService>(() => ParseServerService());
    getIt.registerLazySingleton<MechanicsManager>(() => MechanicsManager());
    getIt.registerLazySingleton<CurrentUser>(() => CurrentUser());
    getIt.registerLazySingleton<FavoritesManager>(() => FavoritesManager());
    getIt.registerLazySingleton<AddressManager>(() => AddressManager());
    getIt.registerLazySingleton<SearchFilter>(() => SearchFilter());
    getIt.registerLazySingleton<SearchHistory>(() => SearchHistory());
    getIt.registerLazySingleton<DatabaseManager>(() => DatabaseManager());
    getIt.registerLazySingleton<BoardgamesManager>(() => BoardgamesManager());

    // Parse Server Repositories
    getIt.registerFactory<IUserRepository>(() => PSUserRepository());
    getIt.registerFactory<IMechanicRepository>(() => PSMechanicsRepository());
    getIt.registerFactory<IAdRepository>(() => PSAdRepository());
    getIt.registerFactory<IBoardgameRepository>(() => PSBoardgameRepository());
    getIt.registerFactory<IAddressRepository>(() => PSAddressRepository());

    // SQFLite Repositories
    getIt.registerFactory<IBgNamesRepository>(() => SqliteBGNamesRepository());
    getIt.registerFactory<ILocalMechanicRepository>(
        () => SqliteMechanicRepository());
    getIt.registerFactory<IFavoriteRepository>(() => PSFavoriteRepository());
  } catch (err) {
    log('GetIt Locator Error: $err');
  }
}

void disposeDependencies() {
  getIt<SearchFilter>().dispose();
  getIt<SearchFilter>().dispose();
  getIt<FavoritesManager>().dispose();
  getIt<CurrentUser>().dispose();
  getIt<AppSettings>().dispose();
}

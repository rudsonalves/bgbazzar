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

import 'repository/app_data/share_preferences/app_share_preferences_repository.dart';
import 'repository/app_data/interfaces/i_app_preferences_repository.dart';
import 'core/singletons/app_settings.dart';
import 'core/singletons/current_user.dart';
import 'core/singletons/search_filter.dart';
import 'core/singletons/search_history.dart';
import 'data_managers/addresses_manager.dart';
import 'data_managers/boardgames_manager.dart';
import 'data_managers/favorites_manager.dart';
import 'data_managers/mechanics_manager.dart';
import 'repository/data/interfaces/i_ad_repository.dart';
import 'repository/data/interfaces/i_address_repository.dart';
import 'repository/data/interfaces/i_boardgame_repository.dart';
import 'repository/data/interfaces/i_favorite_repository.dart';
import 'repository/data/interfaces/i_mechanic_repository.dart';
import 'repository/data/interfaces/i_user_repository.dart';
import 'repository/data/parse_server/ps_address_repository.dart';
import 'repository/data/parse_server/ps_boardgame_repository.dart';
import 'repository/data/parse_server/ps_ad_repository.dart';
import 'repository/data/parse_server/ps_favorite_repository.dart';
import 'repository/data/parse_server/ps_mechanics_repository.dart';
import 'repository/data/parse_server/ps_user_repository.dart';
import 'repository/local_data/sqlite/bg_names_repository.dart';
import 'repository/local_data/interfaces/i_bg_names_repository.dart';
import 'repository/local_data/interfaces/i_local_mechanic_repository.dart';
import 'repository/local_data/sqlite/mechanic_repository.dart';
import 'services/parse_server/parse_server_server.dart';
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
    getIt.registerLazySingleton<AddressesManager>(() => AddressesManager());
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

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'repository/share_preferences/i_app_preferences_repository.dart';
import 'services/parse_server_server.dart';
import 'common/singletons/search_history.dart';
import 'get_it.dart';
import 'manager/boardgames_manager.dart';
import 'manager/mechanics_manager.dart';
import 'my_material_app.dart';
import 'store/database/database_provider.dart';

void main() async {
  const isLocalServer = false;

  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  await getIt<IAppPreferencesRepository>().initialize();

  final parseServer = getIt<ParseServerService>();
  parseServer.init(isLocalServer);

  await getIt<IAppPreferencesRepository>().initialize();

  await DatabaseProvider.initialize();

  getIt<SearchHistory>().init();
  await getIt<BoardgamesManager>().initialize();
  await getIt<MechanicsManager>().initialize();

  runApp(const MyMaterialApp());
}

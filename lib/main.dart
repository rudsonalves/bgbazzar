import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/parse_server_server.dart';
import 'common/singletons/search_history.dart';
import 'get_it.dart';
import 'manager/boardgames_manager.dart';
import 'manager/mechanics_manager.dart';
import 'my_material_app.dart';
import 'store/database/database_provider.dart';

void main() async {
  const isLocalServer = true;

  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  final parseServer = getIt<ParseServerService>();
  parseServer.init(isLocalServer);
  await DatabaseProvider.init();
  await getIt<SearchHistory>().init();
  await getIt<BoardgamesManager>().init();
  await getIt<MechanicsManager>().init();

  runApp(const MyMaterialApp());
}

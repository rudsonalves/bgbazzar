import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'common/settings/parse_server_location.dart';
import 'common/singletons/search_history.dart';
import 'get_it.dart';
import 'manager/boardgames_manager.dart';
import 'manager/mechanics_manager.dart';
import 'my_material_app.dart';
import 'store/database/database_provider.dart';

Future<void> startParseServer() async {
  await Parse().initialize(
    ParseServerLocation.keyApplicationId,
    ParseServerLocation.keyParseServerUrl,
    clientKey: ParseServerLocation.keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );
}

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await startParseServer();

  setupDependencies();
  await DatabaseProvider.init();
  await getIt<SearchHistory>().init();
  await getIt<BoardgamesManager>().init();
  await getIt<MechanicsManager>().init();

  runApp(const MyMaterialApp());
}

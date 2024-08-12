import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'common/settings/local_server.dart';
import 'common/singletons/search_history.dart';
import 'get_it.dart';
import 'manager/bg_names_manager.dart';
import 'manager/mechanics_manager.dart';
import 'my_material_app.dart';

Future<void> startParseServer() async {
  await Parse().initialize(
    LocalServer.keyApplicationId,
    LocalServer.keyParseServerUrl,
    clientKey: LocalServer.keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startParseServer();

  setupDependencies();
  await getIt<SearchHistory>().init();
  await getIt<BgNamesManager>().init();
  await getIt<MechanicsManager>().init();

  runApp(const MyMaterialApp());
}

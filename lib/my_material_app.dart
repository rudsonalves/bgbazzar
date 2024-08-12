// Copyright (C) 2024 rudson
//
// This file is part of xlo_mobx.
//
// xlo_mobx is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// xlo_mobx is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with xlo_mobx.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/models/address.dart';
import 'common/models/ad.dart';
import 'common/models/filter.dart';
import 'common/singletons/app_settings.dart';
import 'common/theme/theme.dart';
import 'common/theme/util.dart';
import 'features/bg_search/bg_search_screen.dart';
import 'features/boardgames/boardgame_screen.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/my_account/my_account_screen.dart';
import 'features/address/address_screen.dart';
import 'features/my_ads/my_ads_screen.dart';
import 'features/my_data/my_data_screen.dart';
import 'features/product/product_screen.dart';
import 'features/filters/filters_screen.dart';
import 'features/mechanics/mechanics_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/shop/shop_screen.dart';
import 'features/edit_ad/edit_ad_screen.dart';
import 'features/login/login_screen.dart';
import 'features/new_address/new_address_screen.dart';
import 'features/signup/signup_screen.dart';
import 'get_it.dart';

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({super.key});

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  final app = getIt<AppSettings>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Manrope", "Comfortaa");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ValueListenableBuilder(
        valueListenable: app.brightness,
        builder: (context, value, _) {
          return MaterialApp(
            theme: value == Brightness.light ? theme.light() : theme.dark(),
            debugShowCheckedModeBanner: false,
            initialRoute: ShopScreen.routeName,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // Inglês
              Locale('pt', 'BR'), // Português do Brasil
            ],
            locale: const Locale('pt', 'BR'),
            routes: {
              ChatScreen.routeName: (_) => const ChatScreen(),
              MyAccountScreen.routeName: (_) => const MyAccountScreen(),
              LoginScreen.routeName: (_) => const LoginScreen(),
              SignUpScreen.routeName: (_) => const SignUpScreen(),
              AddressScreen.routeName: (_) => const AddressScreen(),
              ShopScreen.routeName: (_) => const ShopScreen(),
              MyAdsScreen.routeName: (_) => const MyAdsScreen(),
              MyDataScreen.routeName: (_) => const MyDataScreen(),
              FavoritesScreen.routeName: (_) => const FavoritesScreen(),
              BoardgamesScreen.routeName: (_) => const BoardgamesScreen(),
              BggSearchScreen.routeName: (_) => const BggSearchScreen(),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case EditAdScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final ad = settings.arguments as AdModel?;
                    return EditAdScreen(ad: ad);
                  });

                case ProductScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final ad = settings.arguments as AdModel;

                    return ProductScreen(ad: ad);
                  });

                case FiltersScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final filter = settings.arguments as FilterModel?;

                    return FiltersScreen(filter);
                  });

                case MechanicsScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final selectedIds = settings.arguments as List<int>;

                    return MechanicsScreen(
                      selectedIds: selectedIds,
                    );
                  });

                case NewAddressScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final address = settings.arguments as AddressModel?;

                    return NewAddressScreen(
                      address: address,
                    );
                  });
                default:
                  return null;
              }
            },
          );
        });
  }
}

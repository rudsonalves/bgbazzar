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

import 'core/models/address.dart';
import 'core/models/ad.dart';
import 'core/models/boardgame.dart';
import 'core/models/filter.dart';
import 'core/singletons/app_settings.dart';
import 'core/theme/theme.dart';
import 'core/theme/util.dart';
import 'features/my_account/boardgames/boardgames_screen.dart';
import 'features/my_account/boardgames/widgets/view_boardgame.dart';
import 'features/my_account/boardgames/edit_boardgame/edit_boardgame_screen.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/my_account/my_account_screen.dart';
import 'features/addresses/addresses_screen.dart';
import 'features/my_account/my_ads/my_ads_screen.dart';
import 'features/my_account/my_data/my_data_screen.dart';
import 'features/payment_web_view/payment_page.dart';
import 'features/shop/product/product_screen.dart';
import 'features/filters/filters_screen.dart';
import 'features/my_account/mechanics/mechanics_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/check_mechanics/check_page.dart';
import 'features/shop/shop_screen.dart';
import 'features/edit_ad/edit_ad_screen.dart';
import 'features/signin/signin_screen.dart';
import 'features/addresses/edit_address/edit_address_screen.dart';
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
              SignInScreen.routeName: (_) => const SignInScreen(),
              SignUpScreen.routeName: (_) => const SignUpScreen(),
              AddressesScreen.routeName: (_) => const AddressesScreen(),
              ShopScreen.routeName: (_) => const ShopScreen(),
              MyAdsScreen.routeName: (_) => const MyAdsScreen(),
              MyDataScreen.routeName: (_) => const MyDataScreen(),
              FavoritesScreen.routeName: (_) => const FavoritesScreen(),
              BoardgamesScreen.routeName: (_) => const BoardgamesScreen(),
              CheckPage.routeName: (_) => const CheckPage(),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case PaymentPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final String preferenceId = settings.arguments as String;
                    return PaymentPage(preferenceId: preferenceId);
                  });
                case EditBoardgamesScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final bg = settings.arguments as BoardgameModel?;
                    return EditBoardgamesScreen(bg);
                  });
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
                    final selectedPsIds = settings.arguments as List<String>;

                    return MechanicsScreen(
                      selectedPsIds: selectedPsIds,
                    );
                  });

                case EditAddressScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final address = settings.arguments as AddressModel?;

                    return EditAddressScreen(
                      address: address,
                    );
                  });
                case ViewBoardgame.routeName:
                  return MaterialPageRoute(builder: (context) {
                    final bg = settings.arguments as BoardgameModel;

                    return ViewBoardgame(bg);
                  });
                default:
                  return null;
              }
            },
          );
        });
  }
}

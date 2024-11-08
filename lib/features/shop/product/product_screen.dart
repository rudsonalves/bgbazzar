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

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import '/core/models/ad.dart';
import '/core/singletons/current_user.dart';
import '/components/widgets/favorite_button.dart';
import '/get_it.dart';
import 'widgets/description_product.dart';
import 'widgets/duo_segmented_button.dart';
import 'widgets/game_data.dart';
import 'widgets/image_carousel.dart';
import 'widgets/location_product.dart';
import 'widgets/price_product.dart';
import 'widgets/sub_title_product.dart';
import 'widgets/title_product.dart';
import 'widgets/user_card_product.dart';

const double indent = 0;

class ProductScreen extends StatefulWidget {
  final AdModel ad;

  const ProductScreen({
    super.key,
    required this.ad,
  });

  static const routeName = 'product';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _fabOffsetAnimation;
  late final AdModel ad;
  final _scrollController = ScrollController();
  Timer? _timer;

  bool get isLogged => getIt<CurrentUser>().isLogged;

  @override
  void initState() {
    super.initState();

    ad = widget.ad;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scrollController.addListener(_scrollListener);
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _animationController.dispose();
    _timer?.cancel();

    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward ||
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      _hideFab();
      _resetTimer();
    }
  }

  void _showFab() {
    _animationController.forward();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () {
      _showFab();
    });
  }

  void _hideFab() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ad.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
        position: _fabOffsetAnimation,
        child: DuoSegmentedButton(
          hideButton1: ad.hidePhone,
          label1: 'Ligar',
          iconData1: Icons.phone,
          callBack1: () {
            final phone = ad.owner!.phone!.replaceAll(RegExp(r'[^\d]'), '');
            launchUrl(Uri.parse('tel:$phone'));
          },
          label2: 'Chat',
          iconData2: Icons.chat,
          callBack2: () {
            log('Chat');
          },
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          _hideFab();
          _resetTimer();
          return false;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  ImageCarousel(ad: ad),
                  if (isLogged) FavoriteStackButton(ad: ad),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PriceProduct(price: ad.price),
                    TitleProduct(title: ad.title),
                    const Divider(indent: indent, endIndent: indent),
                    DescriptionProduct(description: ad.description),
                    if (ad.boardgame != null)
                      GameData(
                        ad: ad,
                        indent: indent,
                      ),
                    const Divider(indent: indent, endIndent: indent),
                    LocationProduct(address: ad.address!),
                    const Divider(indent: indent, endIndent: indent),
                    const SubTitleProduct(subtile: 'Anunciante'),
                    UserCard(
                      name: ad.owner!.name!,
                      createAt: ad.owner!.createdAt!,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

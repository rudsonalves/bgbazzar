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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/models/ad.dart';
import '../../../features/product/product_screen.dart';
import '../../../features/shop/shop_controller.dart';
import 'widgets/ad_shop_view.dart';

enum ButtonBehavior { edit, delete }

class ShopGridView extends StatefulWidget {
  final ShopController ctrl;
  final ScrollController scrollController;
  final ButtonBehavior? buttonBehavior;
  final Function(AdModel ad)? editAd;
  final Function(AdModel ad)? deleteAd;

  const ShopGridView({
    super.key,
    required this.ctrl,
    required this.scrollController,
    this.buttonBehavior,
    this.editAd,
    this.deleteAd,
  });

  @override
  State<ShopGridView> createState() => _ShopGridViewState();
}

class _ShopGridViewState extends State<ShopGridView> {
  late ScrollController _scrollController;
  late final ShopController ctrl;
  double _scrollPosition = 0;
  bool _isScrolling = false;

  @override
  initState() {
    super.initState();

    ctrl = widget.ctrl;
    _scrollController = widget.scrollController;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (_scrollController.hasClients &&
        _scrollController.position.atEdge &&
        !_isScrolling) {
      final isBottom = _scrollController.position.pixels != 0;
      if (isBottom) {
        _scrollPosition = _scrollController.position.pixels;
        _isScrolling = true;
        await ctrl.getMoreAds();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // _scrollController.animateTo(
          //   _scrollPosition,
          //   duration: const Duration(microseconds: 300),
          //   curve: Curves.easeInOut,
          // );
          _scrollController.jumpTo(_scrollPosition);
          _isScrolling = false;
        });
      }
    }
  }

  Widget showImage(String image) {
    if (image.isEmpty) {
      final color = Theme.of(context).colorScheme.secondaryContainer;
      return Icon(
        Icons.image_not_supported_outlined,
        color: color,
        size: 150,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      );
    }
  }

  Widget? getItemButton(int index) {
    final ad = ctrl.ads[index];

    switch (widget.buttonBehavior) {
      case null:
        return null;
      case ButtonBehavior.edit:
        return InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            if (widget.editAd != null) widget.editAd!(ad);
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.edit,
              color: Colors.yellowAccent.withOpacity(0.65),
            ),
          ),
        );
      case ButtonBehavior.delete:
        return InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            if (widget.deleteAd != null) widget.deleteAd!(ad);
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.delete,
              color: Colors.redAccent.withOpacity(0.65),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3.4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      controller: _scrollController,
      itemCount: ctrl.ads.length,
      itemBuilder: (context, index) => SizedBox(
        // height: 150,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductScreen.routeName,
              arguments: ctrl.ads[index],
            );
          },
          child: AdShopView(
            ad: ctrl.ads[index],
          ),
        ),
      ),
    );
  }
}

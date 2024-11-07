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

import 'package:flutter/material.dart';

import '../../../../core/models/ad.dart';
import '../../../../components/collection_views/ad_list_view/ad_list_view.dart';
import '../my_ads_controller.dart';

class MyTabBarView extends StatefulWidget {
  final MyAdsController ctrl;
  final ScrollController scrollController;
  final Function(AdModel ad) editAd;
  final Function(AdModel ad) deleteAd;

  const MyTabBarView({
    super.key,
    required this.ctrl,
    required this.scrollController,
    required this.editAd,
    required this.deleteAd,
  });

  @override
  State<MyTabBarView> createState() => _MyTabBarViewState();
}

class _MyTabBarViewState extends State<MyTabBarView> {
  Color? getColorLeft(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return Colors.blue.withOpacity(0.45);
      case 1:
        return Colors.green.withOpacity(0.45);
      default:
        return null;
    }
  }

  Color? getColorRight(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return null;
      case 1:
        return Colors.yellow.withOpacity(0.45);
      default:
        return Colors.blue.withOpacity(0.45);
    }
  }

  String getLabelLeft(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return 'Mover para Ativos';
      case 1:
        return 'Mover para Vendidos';
      default:
        return '';
    }
  }

  String getLabelRight(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return '';
      case 1:
        return 'Mover para Pendentes';
      default:
        return 'Mover para Ativos';
    }
  }

  IconData? getIconLeft(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return Icons.notifications_active;
      case 1:
        return Icons.currency_exchange_rounded;
      default:
        return null;
    }
  }

  IconData? getIconRight(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return null;
      case 1:
        return Icons.notifications_off_outlined;
      default:
        return Icons.notifications_active;
    }
  }

  AdStatus? getStatusLeft(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return AdStatus.active;
      case 1:
        return AdStatus.sold;
      default:
        return null;
    }
  }

  AdStatus? getStatusRight(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return null;
      case 1:
        return AdStatus.pending;
      default:
        return AdStatus.active;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        3,
        (tabIndex) => Padding(
          padding: const EdgeInsets.all(8),
          child: AdListView(
            ads: widget.ctrl.ads,
            getMoreAds: widget.ctrl.getMoreAds,
            scrollController: widget.scrollController,
            enableDismissible: true,
            colorLeft: getColorLeft(tabIndex),
            colorRight: getColorRight(tabIndex),
            labelLeft: getLabelLeft(tabIndex),
            labelRight: getLabelRight(tabIndex),
            iconLeft: getIconLeft(tabIndex),
            iconRight: getIconRight(tabIndex),
            buttonBehavior: tabIndex != 1 ? true : false,
            statusLeft: getStatusLeft(tabIndex),
            statusRight: getStatusRight(tabIndex),
            editAd: widget.editAd,
            deleteAd: widget.deleteAd,
          ),
        ),
      ),
    );
  }
}

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

import '../../common/models/ad.dart';
import '../../components/buttons/big_button.dart';
import '../../components/others_widgets/state_error_message.dart';
import '../../components/others_widgets/state_loading_message.dart';
import 'edit_ad_controller.dart';
import 'edit_ad_state.dart';
import 'widgets/ad_form.dart';
import 'widgets/image_list_view.dart';

class EditAdScreen extends StatefulWidget {
  final AdModel? ad;

  const EditAdScreen({
    super.key,
    this.ad,
  });

  static const routeName = '/insert';

  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  final ctrl = EditAdController();

  @override
  void initState() {
    super.initState();

    ctrl.init(widget.ad);
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  Future<void> _createAnnounce() async {
    AdModel? ad;
    if (!ctrl.formValit) return;
    FocusScope.of(context).unfocus();
    if (widget.ad != null) {
      ad = await ctrl.updateAds(widget.ad!.id!);
    } else {
      ad = await ctrl.createAds();
    }
    if (mounted) Navigator.pop(context, ad);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ad != null ? 'Editar Anúncio' : 'Criar Anúncio'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListenableBuilder(
        listenable: ctrl,
        builder: (context, _) => Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImagesListView(
                      ctrl: ctrl,
                      validator: true,
                    ),
                    AnimatedBuilder(
                      animation:
                          Listenable.merge([ctrl.valit, ctrl.imagesLength]),
                      builder: (context, _) {
                        if ((ctrl.imagesLength.value == 0 &&
                                ctrl.valit.value == null) ||
                            ctrl.imagesLength.value > 0) {
                          return Container();
                        } else {
                          return Text(
                            'Adicionar algumas imagens.',
                            style: TextStyle(
                              color: colorScheme.error,
                            ),
                          );
                        }
                      },
                    ),
                    Column(
                      children: [
                        AdForm(controller: ctrl),
                        BigButton(
                          color: Colors.orange,
                          label: widget.ad != null ? 'Atualizar' : 'Salvar',
                          onPressed: _createAnnounce,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (ctrl.state is EditAdStateLoading) const StateLoadingMessage(),
            if (ctrl.state is EditAdStateError)
              StateErrorMessage(
                closeDialog: ctrl.gotoSuccess,
              ),
          ],
        ),
      ),
    );
  }
}

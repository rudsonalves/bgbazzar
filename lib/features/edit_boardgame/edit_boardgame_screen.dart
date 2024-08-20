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

import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/models/boardgame.dart';
import '../../common/theme/app_text_style.dart';
import '../../components/form_fields/custom_form_field.dart';
import '../../components/form_fields/custom_long_form_field.dart';
import '../../components/form_fields/custom_names_form_field.dart';
import '../../components/others_widgets/spin_box_field.dart';
import '../../components/others_widgets/state_error_message.dart';
import '../../components/others_widgets/state_loading_message.dart';
import '../mechanics/mechanics_screen.dart';
import '../product/widgets/sub_title_product.dart';
import 'edit_boardgame_controller.dart';
import 'edit_boardgame_state.dart';

class EditBoardgamesScreen extends StatefulWidget {
  final BoardgameModel? bg;

  const EditBoardgamesScreen(
    this.bg, {
    super.key,
  });

  static const routeName = '/boardgame';

  @override
  State<EditBoardgamesScreen> createState() => _EditBoardgamesScreenState();
}

class _EditBoardgamesScreenState extends State<EditBoardgamesScreen> {
  final ctrl = EditBoardgameController();

  @override
  void initState() {
    super.initState();

    ctrl.init(widget.bg);
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  void _backPage() {
    Navigator.pop(context);
  }

  Future<void> _backPageWithSave() async {
    await ctrl.saveBoardgame();
    if (mounted) Navigator.pop(context);
  }

  void _setImage() async {
    final controller = TextEditingController();

    final result = await showDialog<bool>(
          context: context,
          builder: (context) => SimpleDialog(
            title: const Text('Image'),
            contentPadding: const EdgeInsets.all(8),
            children: [
              const Text('Entre com o path da imagem:'),
              TextField(
                controller: controller,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: OverflowBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: () => Navigator.pop(context, true),
                      icon: const Icon(Icons.check),
                      label: const Text('Aplicar'),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: () => Navigator.pop(context, false),
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancelar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) ??
        false;
    if (result && controller.text.isNotEmpty) {
      ctrl.imageController.text = controller.text;
    }
    await Future.delayed(const Duration(milliseconds: 50));
    controller.dispose();
  }

  Future<void> _addMecanics() async {
    final mechPsIds = await Navigator.pushNamed(
      context,
      MechanicsScreen.routeName,
      arguments: ctrl.selectedMechIds,
    ) as List<String>?;

    if (mechPsIds != null) {
      ctrl.setMechanicsPsIds(mechPsIds);
      if (mounted) FocusScope.of(context).nextFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width * .8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Board'),
        centerTitle: true,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListenableBuilder(
            listenable: ctrl,
            builder: (context, _) {
              return Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomNamesFormField(
                        labelText: 'Nome do Jogo:',
                        labelStyle: AppTextStyle.font18Bold.copyWith(
                          color: colorScheme.primary,
                        ),
                        hintText: 'Entre o nome do jogo aqui',
                        controller: ctrl.nameController,
                        names: ctrl.bgNames,
                        fullBorder: false,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: ctrl.getBgInfo,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SubTitleProduct(
                              subtile: 'Publicado em: ',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            SpinBoxField(
                              value: 2020,
                              minValue: 1978,
                              maxValue: DateTime.now().year,
                              controller: ctrl.yearController,
                            ),
                          ],
                        ),
                      ),
                      Ink(
                        width: width,
                        height: width,
                        child: ListenableBuilder(
                          listenable: ctrl.imageController,
                          builder: (context, _) {
                            return InkWell(
                              onTap: _setImage,
                              child: (ctrl.imageController.text.isNotEmpty)
                                  ? (ctrl.imageController.text.contains('http'))
                                      ? Image.network(ctrl.imageController.text)
                                      : Image.file(
                                          File(ctrl.imageController.text))
                                  : Icon(
                                      Icons.image_not_supported_rounded,
                                      size: width,
                                      color: colorScheme.tertiaryContainer,
                                    ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SubTitleProduct(
                              subtile: '# de Jogadores:',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            SpinBoxField(
                              value: 2,
                              controller: ctrl.minPlayersController,
                            ),
                            const Text('-'),
                            SpinBoxField(
                              value: 4,
                              controller: ctrl.maxPlayersController,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SubTitleProduct(
                              subtile: 'Tempo (min):',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            SpinBoxField(
                              value: 25,
                              minValue: 12,
                              maxValue: 360,
                              controller: ctrl.minTimeController,
                            ),
                            const Text('-'),
                            SpinBoxField(
                              value: 50,
                              minValue: 12,
                              maxValue: 720,
                              controller: ctrl.maxTimeController,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SubTitleProduct(
                            subtile: 'Idade mínima: ',
                            color: colorScheme.primary,
                            padding: const EdgeInsets.only(top: 8, bottom: 0),
                          ),
                          SpinBoxField(
                            value: 10,
                            minValue: 3,
                            maxValue: 25,
                            controller: ctrl.ageController,
                          ),
                          const Text('+'),
                        ],
                      ),
                      Card(
                        color: colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomFormField(
                            labelText: 'Designer(s):',
                            labelStyle: AppTextStyle.font18Bold.copyWith(
                              color: colorScheme.primary,
                            ),
                            fullBorder: false,
                            controller: ctrl.designerController,
                          ),
                        ),
                      ),
                      Card(
                        color: colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomFormField(
                            labelText: 'Artista(s):',
                            labelStyle: AppTextStyle.font18Bold.copyWith(
                              color: colorScheme.primary,
                            ),
                            fullBorder: false,
                            controller: ctrl.artistController,
                          ),
                        ),
                      ),
                      Card(
                        color: colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomLongFormField(
                            labelText: 'Descrição:',
                            labelStyle: AppTextStyle.font18Bold.copyWith(
                              color: colorScheme.primary,
                            ),
                            controller: ctrl.descriptionController,
                            fullBorder: false,
                            maxLines: null,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _addMecanics,
                        child: AbsorbPointer(
                          child: Card(
                            color: colorScheme.surfaceContainerHigh,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CustomFormField(
                                labelText: 'Mecânicas *',
                                labelStyle: AppTextStyle.font18Bold.copyWith(
                                  color: colorScheme.primary,
                                ),
                                controller: ctrl.mechsController,
                                fullBorder: false,
                                maxLines: null,
                                floatingLabelBehavior: null,
                                readOnly: true,
                                suffixIcon: const Icon(Icons.ads_click),
                              ),
                            ),
                          ),
                        ),
                      ),
                      OverflowBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilledButton.tonalIcon(
                            onPressed: _backPageWithSave,
                            icon: const Icon(Icons.save),
                            label: const Text('Salvar'),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: _backPage,
                            icon: const Icon(Icons.cancel),
                            label: const Text('Cancelar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (ctrl.state is EditBoardgameStateLoading)
                    const Positioned.fill(
                      child: StateLoadingMessage(),
                    ),
                  if (ctrl.state is EditBoardgameStateError)
                    Positioned.fill(
                      child: StateErrorMessage(
                        closeDialog: ctrl.closeErroMessage,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

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

import '../../components/buttons/big_button.dart';
import '../../components/customs_text/read_more_text.dart';
import '../../components/form_fields/custom_names_form_field.dart';
import '../../components/others_widgets/spin_box_field.dart';
import '../../components/others_widgets/state_error_message.dart';
import '../../components/others_widgets/state_loading_message.dart';
import '../bg_search/bg_search_screen.dart';
import '../product/widgets/sub_title_product.dart';
import 'boardgame_controller.dart';
import 'boardgame_state.dart';

class BoardgamesScreen extends StatefulWidget {
  const BoardgamesScreen({super.key});

  static const routeName = '/boardgame';

  @override
  State<BoardgamesScreen> createState() => _BoardgamesScreenState();
}

class _BoardgamesScreenState extends State<BoardgamesScreen> {
  final ctrl = BoardgameController();

  @override
  void initState() {
    super.initState();

    ctrl.init();
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  void _backPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Jogo'),
        centerTitle: true,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListenableBuilder(
            listenable: ctrl,
            builder: (context, _) {
              return Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SubTitleProduct(
                        subtile: 'Nome do Jogo',
                        color: colorScheme.primary,
                        padding: const EdgeInsets.only(top: 8, bottom: 0),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomNamesFormField(
                              controller: ctrl.nameController,
                              names: ctrl.bgNames,
                              fullBorder: false,
                              floatingLabelBehavior: null,
                              textCapitalization: TextCapitalization.sentences,
                              onSubmitted: () {
                                ctrl.getBggInfo();
                              },
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, BggSearchScreen.routeName);
                            },
                            label: const Text('BGG'),
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Column(
                          children: [
                            SubTitleProduct(
                              subtile: 'Número de Jogadores',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: SpinBoxField(
                                    value: 2,
                                    controller: ctrl.minPlayersController,
                                  ),
                                ),
                                const Text('a'),
                                Expanded(
                                  child: SpinBoxField(
                                    value: 4,
                                    controller: ctrl.maxPlayersController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Column(
                          children: [
                            SubTitleProduct(
                              subtile: 'Duração (min)',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: SpinBoxField(
                                    value: 25,
                                    minValue: 12,
                                    maxValue: 360,
                                    controller: ctrl.minTimeController,
                                  ),
                                ),
                                const Text('a'),
                                Expanded(
                                  child: SpinBoxField(
                                    value: 50,
                                    minValue: 12,
                                    maxValue: 720,
                                    controller: ctrl.maxTimeController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SubTitleProduct(
                            subtile: 'Idade recomendada',
                            color: colorScheme.primary,
                            padding: const EdgeInsets.only(top: 8, bottom: 0),
                          ),
                          Expanded(
                            child: SpinBoxField(
                              value: 10,
                              minValue: 3,
                              maxValue: 25,
                              controller: ctrl.ageController,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SubTitleProduct(
                            subtile: 'Descrição',
                            color: colorScheme.primary,
                            padding: const EdgeInsets.only(top: 8, bottom: 0),
                          ),
                          ReadMoreText(
                            ctrl.descriptionController.text,
                            trimMode: TrimMode.line,
                            trimLines: 3,
                            trimExpandedText: '  [ver menos]',
                            trimCollapsedText: '  [ver mais]',
                            colorClickableText: colorScheme.primary,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SubTitleProduct(
                              subtile: 'Complexidade (0-5): ',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            Expanded(
                              child: SpinBoxField(
                                controller: ctrl.weightController,
                                minValue: 0,
                                maxValue: 5,
                                increment: 0.1,
                                fractionDigits: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SubTitleProduct(
                              subtile: 'Pontuação (0-10): ',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            Expanded(
                              child: SpinBoxField(
                                controller: ctrl.averageController,
                                minValue: 0,
                                maxValue: 10,
                                increment: 0.1,
                                fractionDigits: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Column(
                          children: [
                            SubTitleProduct(
                              subtile: 'Mecânicas',
                              color: colorScheme.primary,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                            ),
                            Text(ctrl.mechsController.text),
                          ],
                        ),
                      ),
                      BigButton(
                        color: Colors.yellow.withOpacity(0.45),
                        label: 'Voltar',
                        onPressed: _backPage,
                      ),
                    ],
                  ),
                  if (ctrl.state is BoardgameStateLoading)
                    const Positioned.fill(
                      child: StateLoadingMessage(),
                    ),
                  if (ctrl.state is BoardgameStateError)
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

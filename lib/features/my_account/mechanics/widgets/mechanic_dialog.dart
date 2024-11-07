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

import '../../../../core/models/mechanic.dart';
import '../../../../components/form_fields/custom_form_field.dart';

class MechanicDialog extends StatefulWidget {
  const MechanicDialog({super.key});

  static Future<MechanicModel?> open(BuildContext context) async {
    final result = await showDialog<MechanicModel?>(
      context: context,
      builder: (context) => const MechanicDialog(),
    );
    return result;
  }

  @override
  State<MechanicDialog> createState() => _MechanicDialogState();
}

class _MechanicDialogState extends State<MechanicDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  _addButton() {
    final mech = MechanicModel(
      name: nameController.text,
      description: descriptionController.text,
    );

    Navigator.pop(context, mech);
  }

  _cancelButton() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SimpleDialog(
      backgroundColor: colorScheme.surfaceContainerHigh,
      contentPadding: const EdgeInsets.fromLTRB(12, 12.0, 12, 16.0),
      title: const Text('Nova Mecânica'),
      children: [
        CustomFormField(
          controller: nameController,
          labelText: 'Mecânica',
          hintText: 'Adicione um nome para a mecânica',
          fullBorder: false,
        ),
        CustomFormField(
          controller: descriptionController,
          labelText: 'Descrição',
          hintText: 'Adicione uma descrição',
          fullBorder: false,
          minLines: 1,
          maxLines: 5,
        ),
        OverflowBar(
          alignment: MainAxisAlignment.spaceAround,
          children: [
            FilledButton.tonalIcon(
              onPressed: _addButton,
              label: const Text('Adicionar'),
              icon: const Icon(Icons.add),
            ),
            FilledButton.tonalIcon(
              onPressed: _cancelButton,
              label: const Text('Cancelar'),
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
      ],
    );
  }
}

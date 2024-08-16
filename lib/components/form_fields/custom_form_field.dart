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

class CustomFormField extends StatelessWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool fullBorder;
  final int? maxLines;
  final int? minLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? errorText;
  final String? suffixText;
  final String? prefixText;

  CustomFormField({
    super.key,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.fullBorder = true,
    this.maxLines = 1,
    this.minLines,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.readOnly = false,
    this.suffixIcon,
    this.errorText,
    this.textCapitalization,
    this.suffixText,
    this.prefixText,
  });

  final errorString = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.next,
        minLines: minLines,
        maxLines: maxLines,
        readOnly: readOnly,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle,
          hintText: hintText,
          errorText: errorText,
          suffixIcon: suffixIcon,
          suffixText: suffixText,
          prefixText: prefixText,
          border: fullBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          floatingLabelBehavior: floatingLabelBehavior,
        ),
        onChanged: (value) {
          if (value.length > 2 && validator != null) {
            errorString.value = validator!(value);
          }
        },
        onFieldSubmitted: (value) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
      ),
    );
  }
}

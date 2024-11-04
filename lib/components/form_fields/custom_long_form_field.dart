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
import 'package:flutter/services.dart';

class CustomLongFormField extends StatefulWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool fullBorder;
  final int? maxLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? errorText;
  final String? suffixText;
  final String? prefixText;
  final FocusNode? focusNode;

  const CustomLongFormField({
    super.key,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.fullBorder = true,
    this.maxLines = 1,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.readOnly = false,
    this.suffixIcon,
    this.errorText,
    this.textCapitalization,
    this.suffixText,
    this.prefixText,
    this.focusNode,
  });

  @override
  State<CustomLongFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomLongFormField> {
  final errorString = ValueNotifier<String?>(null);
  final FocusNode _keyBoardFocusNode = FocusNode();
  final FocusNode _textFormFieldFocusNode = FocusNode();
  bool _isShiftPressed = false;

  @override
  void dispose() {
    _keyBoardFocusNode.dispose();
    _textFormFieldFocusNode.dispose();
    errorString.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: KeyboardListener(
        focusNode: _keyBoardFocusNode,
        onKeyEvent: (event) {
          if (widget.controller == null) return;

          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                event.logicalKey == LogicalKeyboardKey.shiftRight) {
              _isShiftPressed = true;
            } else if (event.logicalKey == LogicalKeyboardKey.enter) {
              if (_isShiftPressed) {
                final currentText = widget.controller!.text;
                final newText = '$currentText\n';
                widget.controller!.text = newText;
                widget.controller!.selection = TextSelection.fromPosition(
                  TextPosition(offset: newText.length),
                );
                _isShiftPressed = false; // Reset the Shift state
              } else {
                FocusScope.of(context).nextFocus();
              }
            }
          } else if (event is KeyUpEvent) {
            if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                event.logicalKey == LogicalKeyboardKey.shiftRight) {
              _isShiftPressed = false;
            }
          }
        },
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          focusNode: widget.focusNode ?? _textFormFieldFocusNode,
          keyboardType: widget.keyboardType,
          textInputAction: TextInputAction.none,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            errorText: widget.errorText,
            suffixIcon: widget.suffixIcon,
            suffixText: widget.suffixText,
            prefixText: widget.prefixText,
            border: widget.fullBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                : null,
            floatingLabelBehavior: widget.floatingLabelBehavior,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

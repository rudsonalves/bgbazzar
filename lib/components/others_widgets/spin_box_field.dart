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

import 'package:flutter/material.dart';

class SpinBoxField extends StatefulWidget {
  final num? value;
  final Widget? label;
  final TextStyle? style;
  final String? hintText;
  final TextEditingController controller;
  final int flex;
  final num minValue;
  final num maxValue;
  final num increment;
  final InputDecoration? decoration;
  final int fractionDigits;

  const SpinBoxField({
    super.key,
    this.value,
    this.label,
    this.style,
    this.hintText,
    required this.controller,
    this.flex = 1,
    this.minValue = 0,
    this.maxValue = 10,
    this.increment = 1,
    this.decoration,
    this.fractionDigits = 0,
  });

  @override
  State<SpinBoxField> createState() => _SpinBoxFieldState();
}

class _SpinBoxFieldState extends State<SpinBoxField> {
  late num value;
  Timer? _incrementTimer;
  Timer? _decrementTimer;
  bool _isLongPressActive = false;
  bool _internalChange = false;

  @override
  void initState() {
    super.initState();

    value = widget.value ?? 0;
    widget.controller.text = value.toStringAsFixed(widget.fractionDigits);

    widget.controller.addListener(() {
      if (_internalChange) return;
      value = num.tryParse(widget.controller.text) ?? 0;
      if (value == 0 || widget.fractionDigits == 0) return;
      String text = value.toStringAsFixed(widget.fractionDigits);
      value = num.parse(text);
      _internalChange = true;
      widget.controller.text = text;
      _internalChange = false;
    });
  }

  void _longIncrement() {
    _incrementTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (value < widget.maxValue) {
          _increment();
        } else {
          _incrementTimer?.cancel();
        }
      },
    );
  }

  void _longDecrement() {
    _decrementTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (value > widget.minValue) {
          _decrement();
        } else {
          _decrementTimer?.cancel();
        }
      },
    );
  }

  void _stopIncrement() {
    _incrementTimer?.cancel();
  }

  void _stopDecrement() {
    _decrementTimer?.cancel();
  }

  void _increment() {
    if (value < widget.maxValue) {
      value += widget.increment;
      value = value > widget.maxValue ? widget.maxValue : value;
      _changeText(value);
    }
  }

  void _decrement() {
    if (value > widget.minValue) {
      value -= widget.increment;
      value = value < widget.minValue ? widget.minValue : value;
      _changeText(value);
    }
  }

  void _changeText(num value) {
    _internalChange = true;
    widget.controller.text = value.toStringAsFixed(widget.fractionDigits);
    _internalChange = false;
  }

  void _onLongPressIncrement() {
    _isLongPressActive = true;
    _longIncrement();
  }

  void _onLongPressDecrement() {
    _isLongPressActive = true;
    _longDecrement();
  }

  void _onLongPressEndIncrement(LongPressEndDetails details) {
    _isLongPressActive = false;
    _stopIncrement();
  }

  void _onLongPressEndDecrement(LongPressEndDetails details) {
    _isLongPressActive = false;
    _stopDecrement();
  }

  void _onTapDecrement() {
    if (!_isLongPressActive) {
      _decrement();
    }
  }

  void _onTapIncrement() {
    if (!_isLongPressActive) {
      _increment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          if (widget.label != null) widget.label!,
          GestureDetector(
            onLongPress: _onLongPressDecrement,
            onLongPressEnd: _onLongPressEndDecrement,
            child: InkWell(
              onTap: _onTapDecrement,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ),
          ListenableBuilder(
              listenable: widget.controller,
              builder: (context, _) {
                return Text(
                  widget.controller.text.trim(),
                  textAlign: TextAlign.center,
                );
              }),
          GestureDetector(
            onLongPress: _onLongPressIncrement,
            onLongPressEnd: _onLongPressEndIncrement,
            child: InkWell(
              onTap: _onTapIncrement,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

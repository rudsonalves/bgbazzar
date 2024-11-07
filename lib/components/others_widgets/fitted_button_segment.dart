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

/// A custom button segment widget that ensures the label text fits within the
/// available space.
///
/// `FittedButtonSegment` is a specialized version of `ButtonSegment` that
/// accepts a label and an icon. The label is wrapped in a `FittedBox` with
/// `BoxFit.scaleDown` to prevent text overflow by scaling down the text if it
/// exceeds the button's width.
///
/// This widget is useful for creating responsive button segments, especially in
/// layouts where button text may need to adapt to smaller spaces.
///
/// Type Parameters:
/// - `T`: The data type associated with this button segment's value.
///
/// Parameters:
/// - `key`: An optional unique key for the widget.
/// - `value`: The value associated with this segment, inherited from
///   `ButtonSegment`.
/// - `label`: The text label displayed on the button.
/// - `iconData`: The icon to display alongside the label.
///
/// Example:
/// ```dart
/// FittedButtonSegment<int>(
///   value: 1,
///   label: "Segment Label",
///   iconData: Icons.star,
/// );
/// ```
class FittedButtonSegment<T> extends ButtonSegment<T> {
  FittedButtonSegment({
    Key? key,
    required super.value,
    required String label,
    required IconData iconData,
  }) : super(
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label),
          ),
          icon: Icon(iconData),
        );
}

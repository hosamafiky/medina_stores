import 'package:flutter/material.dart';

extension SpacedColumnExt on Column {
  Column separateWith({required Widget separator}) {
    var spacedChildren = children.expand((widget) => [widget, separator]).toList();
    if (spacedChildren.isNotEmpty) {
      spacedChildren.removeLast(); // Remove the extra Separator
    }

    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: spacedChildren,
    );
  }

  Column withSpacing({double spacing = 10}) {
    var spacedChildren = children.expand((widget) => [widget, SizedBox(height: spacing.toDouble())]).toList();
    if (spacedChildren.isNotEmpty) {
      spacedChildren.removeLast(); // Remove the extra SizedBox
    }

    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: spacedChildren,
    );
  }
}

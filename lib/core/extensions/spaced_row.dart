import 'package:flutter/material.dart';

extension SpacedRowExt on Row {
  Row separateWith({required Widget separator}) {
    var spacedChildren = children.expand((widget) => [widget, separator]).toList();
    if (spacedChildren.isNotEmpty) spacedChildren.removeLast(); // Remove the extra Separator

    return Row(
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

  Row withSpacing({double spacing = 10}) {
    var spacedChildren = children.expand((widget) => [widget, SizedBox(width: spacing.toDouble())]).toList();
    if (spacedChildren.isNotEmpty) spacedChildren.removeLast(); // Remove the extra SizedBox

    return Row(
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

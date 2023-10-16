import 'package:flutter/material.dart';
import 'package:great_places/theme/theme_builder.dart';

extension MaterialStateSet on Set<MaterialState> {
  bool get isHovered => contains(MaterialState.hovered);
  bool get isPressed => contains(MaterialState.pressed);
  bool get isDisabled => contains(MaterialState.disabled);
}

class ElevatedButtonStyle {
  final colorScheme = ThemeBuilder.createColorScheme();
  final textTheme = ThemeBuilder.createTextTheme();

  Color getIconColor(Set<MaterialState> states) {
    return colorScheme.background;
  }

  Color getBackgroundColor(Set<MaterialState> states) => colorScheme.primary;

  Color getOverlayColor(Set<MaterialState> states) {
    return colorScheme.tertiary;
  }
}

import 'package:flutter/material.dart';
import 'package:great_places/theme/theme_builder.dart';

class FloatingActionButtonStyle {
  final colorScheme = ThemeBuilder.createColorScheme();
  final textTheme = ThemeBuilder.createTextTheme();

  static FloatingActionButtonThemeData createThemeData() {
    final style = FloatingActionButtonStyle();
    return FloatingActionButtonThemeData(
      backgroundColor: style.colorScheme.primary,
    );
  }
}

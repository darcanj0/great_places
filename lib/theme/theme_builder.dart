import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:great_places/theme/elevated_button.dart';

class ThemeBuilder {
  static ColorScheme createColorScheme() {
    return ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 189, 40, 144));
  }

  static TextTheme createTextTheme() {
    final colorScheme = createColorScheme();
    final TextTheme originalTextTheme = const TextTheme().copyWith(
      labelMedium: TextStyle(
        color: colorScheme.onBackground,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        color: colorScheme.background,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: colorScheme.onBackground,
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
    );

    return GoogleFonts.interTextTheme(originalTextTheme);
  }

  static ThemeData createTheme() {
    final elevatedButtonStyle = ElevatedButtonStyle();

    return ThemeData(
      colorScheme: createColorScheme(),
      textTheme: createTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          iconColor:
              MaterialStateColor.resolveWith(elevatedButtonStyle.getIconColor),
          backgroundColor: MaterialStateColor.resolveWith(
              elevatedButtonStyle.getBackgroundColor),
          overlayColor: MaterialStateColor.resolveWith(
              elevatedButtonStyle.getOverlayColor),
        ),
      ),
      useMaterial3: true,
    );
  }
}

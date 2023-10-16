import 'package:flutter/material.dart';
import 'package:great_places/constants/app_routes.dart';
import 'package:great_places/pages/place_form_page.dart';
import 'package:great_places/pages/places_page.dart';
import 'package:great_places/theme/theme_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeBuilder.createTheme(),
      home: const PlacesPage(),
      routes: {
        AppRoutes.HOME: (context) => PlacesPage(),
        AppRoutes.PLACE_FORM: (context) => PlaceFormPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

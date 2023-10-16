import 'package:flutter/material.dart';
import 'package:great_places/constants/app_routes.dart';
import 'package:great_places/pages/place_form_page.dart';
import 'package:great_places/pages/places_page.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:great_places/theme/theme_builder.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => GreatPlacesProvider(),
      )
    ],
    child: const MyApp(),
  ));
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
        AppRoutes.HOME: (context) => const PlacesPage(),
        AppRoutes.PLACE_FORM: (context) => const PlaceFormPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

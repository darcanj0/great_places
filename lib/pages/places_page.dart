import 'package:flutter/material.dart';
import 'package:great_places/components/great_places_list.dart';
import 'package:great_places/constants/app_routes.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: GreatPlacesList(),
    );
  }
}

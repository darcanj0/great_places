import 'package:flutter/material.dart';
import 'package:great_places/components/scroll_wrapper.dart';
import 'package:great_places/constants/app_routes.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:provider/provider.dart';

import '../components/great_place_card.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({super.key});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
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
      body: RefreshIndicator.adaptive(
        onRefresh: context.read<GreatPlacesProvider>().loadPlaces,
        child: FutureBuilder(
            future: context.read<GreatPlacesProvider>().loadPlaces(),
            builder: (ctx, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlacesProvider>(
                      builder: (ctx, placesProvider, child) => ScrollWrapper(
                            child: ListView.builder(
                              itemCount: placesProvider.placesCount,
                              itemBuilder: (_, index) {
                                final place = placesProvider.places[index];
                                return GreatPlaceCard(
                                  place: place,
                                  key: Key(place.id),
                                );
                              },
                            ),
                          ));
            }),
      ),
    );
  }
}

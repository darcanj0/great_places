import 'package:flutter/material.dart';
import 'package:great_places/components/great_place_card.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:provider/provider.dart';

class GreatPlacesList extends StatelessWidget {
  const GreatPlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GreatPlacesProvider>(
      builder: (_, placesProvider, __) {
        return ListView.builder(
          itemCount: placesProvider.placesCount,
          itemBuilder: (_, index) {
            final Place place = placesProvider.places[index];
            return GreatPlaceCard(
              place: place,
              key: Key(place.id),
            );
          },
        );
      },
    );
  }
}

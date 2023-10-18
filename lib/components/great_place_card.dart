import 'package:flutter/material.dart';
import 'package:great_places/constants/app_routes.dart';
import 'package:great_places/utils/theme_consumer.dart';

import '../models/place.dart';

class GreatPlaceCard extends StatelessWidget with ThemeConsumer {
  const GreatPlaceCard({required this.place, super.key});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.PLACE_DETAILS,
            arguments: place,
          );
        },
        leading: CircleAvatar(
          backgroundImage: FileImage(place.image),
          radius: 30,
        ),
        title: Text(
          place.title,
          style: getTextTheme(context)?.headlineMedium,
        ),
        subtitle: Text(
          place.address.toDisplay,
          style: getTextTheme(context)?.labelSmall,
        ),
        key: key,
      ),
    );
  }
}

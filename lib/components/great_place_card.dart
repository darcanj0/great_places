import 'package:flutter/material.dart';

import '../models/place.dart';

class GreatPlaceCard extends StatelessWidget {
  const GreatPlaceCard({required this.place, super.key});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(place.image),
          radius: 40,
        ),
        title: Text(place.title),
        key: key,
      ),
    );
  }
}

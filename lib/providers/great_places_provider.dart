import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_adapter.dart';
import 'package:great_places/utils/id_adapter.dart';

class GreatPlacesProvider extends UUIDAdapter with ChangeNotifier {
  final DbAdapter dbAdapter;

  GreatPlacesProvider({required this.dbAdapter});

  final List<Place> _places = [];
  List<Place> get places => [..._places];
  int get placesCount => _places.length;
  Place getPlaceByIndex(int index) {
    return _places[index];
  }

  Future<void> addPlace(
    String title,
    File image,
  ) async {
    final place = Place(
        id: genId(),
        title: title,
        location: const PlaceCoordinates(lat: 0.0, long: 0.0),
        image: image);
    _places.add(place);

    await dbAdapter.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
    });
    notifyListeners();
  }

  Future<void> loadPlaces() async {
    _places.clear();
    final list = await dbAdapter.query('places');
    for (var data in list) {
      final place = Place(
        id: data['id'] as String,
        title: data['title'] as String,
        location: const PlaceCoordinates(lat: 0, long: 0),
        image: File(data['image'] as String),
      );
      _places.add(place);
    }
    notifyListeners();
  }
}

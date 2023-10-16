import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/uuid_adapter.dart';

class GreatPlacesProvider extends UUIDAdapter with ChangeNotifier {
  final List<Place> _places = [];
  List<Place> get places => [..._places];
  int get placesCount => _places.length;
  Place getPlaceByIndex(int index) {
    return _places[index];
  }

  void addPlace(String title, File image) {
    _places.add(
      Place(
          id: genId(),
          title: title,
          location: PlaceCoordinates(lat: 0.0, long: 0.0),
          image: image),
    );
    notifyListeners();
  }
}

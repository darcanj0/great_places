import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  final List<Place> _places = [];
  List<Place> get places => [..._places];
  int get placesCount => _places.length;
  Place getPlaceByIndex(int index) {
    return _places[index];
  }
}

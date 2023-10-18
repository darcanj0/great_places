import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_adapter.dart';
import 'package:great_places/utils/id_adapter.dart';
import 'package:geocoding/geocoding.dart';

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
    PlaceCoordinates coordinates,
  ) async {
    final Address address = await getAddressFrom(coordinates);
    final place = Place(
      id: genId(),
      title: title,
      location: coordinates,
      image: image,
      address: address,
    );
    _places.add(place);

    await dbAdapter.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': place.location.lat,
      'long': place.location.long,
      'address': place.address.toPersistance,
    });
    notifyListeners();
  }

  Future<void> loadPlaces() async {
    _places.clear();
    final list = await dbAdapter.query('places');
    for (var data in list) {
      final deconstructedAddress = data['address'].toString().split(', ');
      final place = Place(
        id: data['id'] as String,
        title: data['title'] as String,
        location: PlaceCoordinates(
            lat: (data['lat'] as double), long: data['long'] as double),
        image: File(data['image'] as String),
        address: Address(
          country: deconstructedAddress.elementAt(0),
          street: deconstructedAddress.elementAt(2),
          subLocality: deconstructedAddress.elementAt(1),
        ),
      );
      _places.add(place);
    }
    notifyListeners();
  }

  Future<Address> getAddressFrom(PlaceCoordinates coordinates) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(coordinates.lat, coordinates.long);
    final Placemark firstPlaceMark = placemarks.elementAt(0);
    return Address(
      country: firstPlaceMark.country ?? '',
      street: firstPlaceMark.street ?? '',
      subLocality: firstPlaceMark.subLocality ?? firstPlaceMark.locality ?? '',
    );
  }
}

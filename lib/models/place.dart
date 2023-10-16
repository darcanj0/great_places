import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceCoordinates location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}

class PlaceCoordinates {
  final double lat;
  final double long;
  String address;

  PlaceCoordinates({
    required this.lat,
    required this.long,
    this.address = '',
  });
}

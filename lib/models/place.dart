import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceCoordinates location;
  final File image;
  final Address address;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image,
      this.address = const Address(
          country: 'country', street: 'street', subLocality: 'subLocality')});
}

class PlaceCoordinates {
  final double lat;
  final double long;

  bool get nullPlace => lat == 0 && long == 0;

  const PlaceCoordinates({
    required this.lat,
    required this.long,
  });
}

class Address {
  final String country;
  final String street;
  final String subLocality;

  String get toPersistance => [country, subLocality, street].join(', ');
  String get toDisplay => [country, subLocality, street]
      .where((element) => element.isNotEmpty)
      .join(', ');

  const Address({
    required this.country,
    required this.street,
    required this.subLocality,
  });
}

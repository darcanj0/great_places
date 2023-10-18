import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  Future<bool> checkServiceStatus() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      await requestService();
    }
    return _serviceEnabled;
  }

  Future<void> requestService() async {
    _serviceEnabled = await location.requestService();
    notifyListeners();
  }

  bool isDenied(PermissionStatus status) {
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.deniedForever) {
      return true;
    }
    return false;
  }

  Future<bool> checkPermissionStatus() async {
    _permissionGranted = await location.hasPermission();
    if (isDenied(_permissionGranted)) {
      _permissionGranted = await location.requestPermission();
      if (isDenied(_permissionGranted)) {
        return false;
      }
    }
    return true;
  }

  Future<LocationData> getCurrentLocation() async {
    final data = await location.getLocation();
    return data;
  }

  static const googleApiKey = 'AIzaSyABvoXH2o3dDUouGLHfAeIxohtfjdCvJHo';

  String generateLocationPreviewImage(PlaceCoordinates coordinates) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${coordinates.lat},${coordinates.long}&zoom=14&size=600x300&maptype=roadmap&markers=color:red%7Clabel:P%7C${coordinates.lat},${coordinates.long}&key=$googleApiKey';
  }
}

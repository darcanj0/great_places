import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  Future<bool> checkServiceStatus() async {
    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
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

  Future<LocationData?> getCurrentLocation() async {
    bool hasPermission = await checkPermissionStatus();
    if (!hasPermission) return null;
    final data = await location.getLocation();
    print(data.altitude);
    print(data.latitude);
    print(data.longitude);
    return data;
  }
}

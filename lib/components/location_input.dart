import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/location_provider.dart';
import 'package:great_places/utils/theme_consumer.dart';
import 'package:provider/provider.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> with ThemeConsumer {
  PlaceCoordinates coordinates = PlaceCoordinates(lat: 0, long: 0);
  String staticMapUrl = '';
  bool isLoadingLocation = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (ctx, locationProvider, child) {
      void getLocation() {
        locationProvider.getCurrentLocation().then((locationData) {
          setState(() {
            isLoadingLocation = false;
            coordinates = PlaceCoordinates(
              lat: locationData.latitude!,
              long: locationData.longitude!,
            );
            staticMapUrl =
                locationProvider.generateLocationPreviewImage(coordinates);
          });
        });
      }

      void tryGetStaticLocation() {
        setState(() {
          isLoadingLocation = true;
        });
        locationProvider.checkPermissionStatus().then((enabled) {
          if (enabled) {
            getLocation();
          } else {
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(
                content: Text('Please enable location in your phone settings'),
              ),
            );
            setState(() {
              isLoadingLocation = false;
            });
          }
        });
      }

      return Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.black26,
                )),
            child: (!isLoadingLocation && coordinates.nullPlace)
                ? Text(
                    'No location was informed',
                    style: getTextTheme(context)?.labelLarge,
                  )
                : isLoadingLocation
                    ? const CircularProgressIndicator.adaptive()
                    : Image.network(
                        staticMapUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: tryGetStaticLocation,
                icon: const Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style: getTextTheme(context)?.bodyMedium?.copyWith(
                        color: getColorScheme(context)?.primary,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: Text(
                  'Select from map',
                  style: getTextTheme(context)?.bodyMedium?.copyWith(
                        color: getColorScheme(context)?.primary,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              )
            ],
          )
        ],
      );
    });
  }
}

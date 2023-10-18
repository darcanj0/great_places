import 'package:flutter/material.dart';
import 'package:great_places/providers/location_provider.dart';
import 'package:great_places/utils/theme_consumer.dart';
import 'package:provider/provider.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> with ThemeConsumer {
  String previewImageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
        builder: (ctx, locationProvider, child) => Column(
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
                  child: previewImageUrl.isEmpty
                      ? Text(
                          'No location was informed',
                          style: getTextTheme(context)?.labelLarge,
                        )
                      : Image.network(
                          previewImageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        locationProvider.checkServiceStatus().then((value) {
                          if (value) {
                            locationProvider.getCurrentLocation();
                          } else {
                            return;
                          }
                        });
                      },
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
            ));
  }
}

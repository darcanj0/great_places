import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    required this.title,
    this.initialPlace =
        const PlaceCoordinates(lat: 37.422131, long: -122.084801),
    this.isReadOnly = false,
    super.key,
  });
  final bool isReadOnly;
  final PlaceCoordinates initialPlace;
  final String title;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? selectedPlace;

  void selectPlace(LatLng position) {
    setState(() {
      selectedPlace = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    void confirmSelection() {
      Navigator.of(context).pop(
        PlaceCoordinates(
            lat: selectedPlace!.latitude, long: selectedPlace!.longitude),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (!widget.isReadOnly && selectedPlace != null)
            IconButton(
              onPressed: confirmSelection,
              icon: const Icon(Icons.done),
            )
        ],
      ),
      body: GoogleMap(
        onTap: widget.isReadOnly ? null : selectPlace,
        markers: selectedPlace == null
            ? {
                Marker(
                  markerId: const MarkerId('initial'),
                  position: LatLng(
                    widget.initialPlace.lat,
                    widget.initialPlace.long,
                  ),
                )
              }
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position: selectedPlace as LatLng,
                )
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialPlace.lat, widget.initialPlace.long),
          zoom: 13,
        ),
      ),
    );
  }
}

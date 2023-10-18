import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/pages/map_page.dart';
import 'package:great_places/utils/theme_consumer.dart';

class PlaceDetailsPage extends StatelessWidget with ThemeConsumer {
  const PlaceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)?.settings.arguments as Place;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 450,
            backgroundColor: getColorScheme(context)?.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(place.title),
              background: Image.file(
                place.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 25,
                        color: getColorScheme(context)?.primary,
                      ),
                      Text(
                        place.address.toDisplay,
                        style: getTextTheme(context)?.labelSmall?.copyWith(
                            color: getColorScheme(context)?.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapPage(
                        isReadOnly: true,
                        initialPlace: place.location,
                      ),
                    ));
                  },
                  icon: const Icon(Icons.map),
                  label: Text(
                    'See in map',
                    style: getTextTheme(context)?.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(
                height: 1000,
                width: double.infinity,
              )
            ]),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projj11_favorite_places/models/place.dart';
import 'package:projj11_favorite_places/providers/places_provider.dart';
import 'package:projj11_favorite_places/screens/place_details.dart';

class PlacesList extends ConsumerStatefulWidget {
  const PlacesList({required this.placeList, super.key});

  final List<Place> placeList;
  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {
  @override
  Widget build(BuildContext context) {
    final places = widget.placeList;

    Widget content = Center(
      child: Text(
        'No places here, add some!',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );

    return places.isEmpty
        ? content
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      place.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    subtitle: Text(
                      place.location.address,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    visualDensity: VisualDensity.comfortable,
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage: FileImage(place.image),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) {
                            return PlaceDetails(place: place);
                          },
                        ),
                      );
                    },
                    trailing: IconButton(
                      onPressed: () {
                        ref.read(placesProvider.notifier).removePlace(place.id);
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ),
                  const Divider(
                    indent: 24,
                    endIndent: 24,
                  ),
                ],
              );
            },
          );
  }
}

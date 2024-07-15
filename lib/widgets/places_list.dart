import 'package:flutter/material.dart';
import 'package:projj11_favorite_places/models/place.dart';
import 'package:projj11_favorite_places/screens/place_details.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({required this.placeList,required this.onRemove, super.key});

  final List<Place> placeList;
  final Function(Place) onRemove;

  @override
  Widget build(BuildContext context) {
    if (placeList.isEmpty) {
      return Center(
        child: Text(
          'No places here, add some!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    }
    return ListView.builder(
      itemCount: placeList.length,
      itemBuilder: (context, index) {
        final place = placeList[index];
        return Column(
          children: [
            ListTile(
              visualDensity: VisualDensity.comfortable,
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(place.image),
              ),
              title: Text(
                place.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                place.location.address,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              trailing: IconButton(
                onPressed:() => onRemove(place),
                icon: const Icon(Icons.delete_forever),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return PlaceDetails(place: place);
                    },
                  ),
                );
              },
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

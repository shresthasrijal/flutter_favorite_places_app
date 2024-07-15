import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projj11_favorite_places/models/place.dart';
import 'package:projj11_favorite_places/providers/places_provider.dart';
import 'package:projj11_favorite_places/screens/add_place.dart';
import 'package:projj11_favorite_places/widgets/places_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(placesProvider);

    void _handleRemovePlace(Place place) {
      ref.read(placesProvider.notifier).removePlace(place.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return const AddPlaceDetails();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : PlacesList(
                      placeList: userPlaces,
                      onRemove: _handleRemovePlace,
                    ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projj11_favorite_places/models/place.dart';
import 'package:projj11_favorite_places/providers/places_provider.dart';
import 'package:projj11_favorite_places/widgets/image_input.dart';
import 'package:projj11_favorite_places/widgets/location_input.dart';

class AddPlaceDetails extends ConsumerStatefulWidget {
  const AddPlaceDetails({super.key});

  @override
  ConsumerState<AddPlaceDetails> createState() => _AddPlaceDetailsState();
}

class _AddPlaceDetailsState extends ConsumerState<AddPlaceDetails> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _saveItem() {
    if (_formKey.currentState!.validate() &&
        _selectedImage != null &&
        _selectedLocation != null) {
      _formKey.currentState!.save();
      ref.read(placesProvider.notifier).addplace(
            _enteredTitle,
            _selectedImage!,
            _selectedLocation!,
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place!'),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade600, width: 1.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: _enteredTitle,
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Title')),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredTitle = value!;
                  },
                ),
                const SizedBox(height: 10),
                ImageInput(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                ),
                const SizedBox(height: 10),
                LocationInput(
                  onPickLocation: (selectlocation) {
                    _selectedLocation = selectlocation;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _saveItem,
                      label: const Text('Add Place'),
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

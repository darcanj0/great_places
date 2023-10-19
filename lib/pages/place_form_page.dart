import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/components/location_input.dart';
import 'package:great_places/components/scroll_wrapper.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:great_places/utils/exception_feedback_handler.dart';
import 'package:great_places/utils/theme_consumer.dart';
import 'package:provider/provider.dart';

import '../components/image_input.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({super.key});

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> with ThemeConsumer {
  @override
  void initState() {
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;

  File? selectedImage;
  void selectImage(File picked) {
    setState(() {
      selectedImage = picked;
    });
  }

  PlaceCoordinates? coordinates;
  void selectCoordinates(PlaceCoordinates picked) {
    setState(() {
      coordinates = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> submitForm() async {
      if (_formKey.currentState!.validate()) {
        if (selectedImage == null) {
          ExceptionFeedbackHandler.withSnackbar(
              context, 'You must select an image for your place!');
          return;
        }
        if (coordinates == null) {
          ExceptionFeedbackHandler.withSnackbar(
              context, 'You must select a location for your place!');
          return;
        }
        context.read<GreatPlacesProvider>().addPlace(
              titleController.text,
              selectedImage as File,
              coordinates as PlaceCoordinates,
            );
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Place'),
      ),
      body: SingleChildScrollView(
        child: ScrollWrapper(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) {
                            return;
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please inform a name for this place';
                            }
                            if (value.length > 50) {
                              return 'Please inform a shorter name (50)';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        const SizedBox(height: 20),
                        ImageInput(onSelectImage: selectImage),
                        const SizedBox(height: 20),
                        LocationInput(onSelectCoordinates: selectCoordinates),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submitForm,
        label: Text(
          'Save Place',
          style: getTextTheme(context)?.bodyMedium,
        ),
        icon: Icon(
          Icons.save,
          color: getColorScheme(context)?.background,
        ),
      ),
    );
  }
}

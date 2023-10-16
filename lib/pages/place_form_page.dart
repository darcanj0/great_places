import 'package:flutter/material.dart';
import 'package:great_places/utils/theme_consumer.dart';

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

  late final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Place'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) {
                          return;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                      const ImageInput(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(
          Icons.save,
          color: getColorScheme(context)?.background,
        ),
        label: Text(
          'Save Place',
          style: getTextTheme(context)?.bodyMedium,
        ),
      ),
    );
  }
}

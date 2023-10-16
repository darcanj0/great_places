import 'package:flutter/material.dart';
import 'package:great_places/components/image_input.dart';
import 'package:great_places/utils/theme_consumer.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Form(
            child: Column(
          children: [
            TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  return;
                },
                validator: (value) {
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Title'),
                style: getTextTheme(context)!.bodyLarge!),
            const SizedBox(
              height: 20,
            ),
            ImageInput()
          ],
        )),
      ),
    );
  }
}

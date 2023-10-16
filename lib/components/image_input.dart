import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: Text(
            'No image',
            style: textTheme.labelMedium,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.photo_camera),
          label: Text(
            'Take a picture',
            style: textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:great_places/utils/theme_consumer.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return isLandscape
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImagePreview(
                isLandscape: isLandscape,
                textTheme: textTheme,
              ),
              CustomSpacer(isLandscape: isLandscape),
              const PictureButton()
            ],
          )
        : Column(
            children: [
              ImagePreview(
                isLandscape: isLandscape,
                textTheme: textTheme,
              ),
              CustomSpacer(isLandscape: isLandscape),
              const PictureButton()
            ],
          );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.isLandscape,
    required this.textTheme,
  });

  final bool isLandscape;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isLandscape ? 350 : 250,
      height: isLandscape ? 180 : 150,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: Text(
        'No image',
        style: textTheme.labelMedium,
      ),
    );
  }
}

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({
    super.key,
    required this.isLandscape,
  });

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isLandscape ? 0 : 10,
      width: isLandscape ? 20 : 0,
    );
  }
}

class PictureButton extends StatelessWidget with ThemeConsumer {
  const PictureButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.photo_camera),
      label: Text(
        'Take a picture',
        style: getTextTheme(context)?.bodyMedium?.copyWith(
              color: getColorScheme(context)?.primary,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/utils/theme_consumer.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;
  Future<void> takePicture() async {
    final loadedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 800);
    if (loadedImage == null) return;
    setState(() {
      selectedImage = File(loadedImage.path);
    });
  }

  Future<void> selectFromGallery() async {
    final loadedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 800);
    if (loadedImage == null) return;
    setState(() {
      selectedImage = File(loadedImage.path);
    });
  }

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
                file: selectedImage,
              ),
              CustomSpacer(isLandscape: isLandscape),
              Column(
                children: [
                  PictureButton(
                    onClick: takePicture,
                  ),
                  GalleryButton(
                    onClick: selectFromGallery,
                  )
                ],
              )
            ],
          )
        : Column(
            children: [
              ImagePreview(
                isLandscape: isLandscape,
                textTheme: textTheme,
                file: selectedImage,
              ),
              CustomSpacer(isLandscape: isLandscape),
              PictureButton(
                onClick: takePicture,
              ),
              GalleryButton(
                onClick: selectFromGallery,
              )
            ],
          );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.isLandscape,
    required this.textTheme,
    required this.file,
  });

  final File? file;
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
      child: file != null
          ? FadeInImage(
              image: FileImage(file!),
              placeholder: const AssetImage("assets/images/missing_image.png"),
            )
          : Text(
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
  PictureButton({
    super.key,
    required this.onClick,
  });

  Future<void> Function() onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onClick,
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

class GalleryButton extends StatelessWidget with ThemeConsumer {
  GalleryButton({
    super.key,
    required this.onClick,
  });

  Future<void> Function() onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onClick,
      icon: const Icon(Icons.photo),
      label: Text(
        'Select from gallery',
        style: getTextTheme(context)?.bodyMedium?.copyWith(
              color: getColorScheme(context)?.primary,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}

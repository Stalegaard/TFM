import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera_gallery_image_picker/camera_gallery_image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Camera Gallery Image Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CameraGalleryImagePickerExample(),
    );
  }
}

class CameraGalleryImagePickerExample extends StatefulWidget {
  const CameraGalleryImagePickerExample({super.key});

  @override
  State<CameraGalleryImagePickerExample> createState() =>
      _CameraGalleryImagePickerState();
}

class _CameraGalleryImagePickerState
    extends State<CameraGalleryImagePickerExample> {
  File? _imageFile;
  final List<File> _multipleImageFiles = [];

  void _showLimitExceededMessage() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('No puedes seleccionar más de 5 imágenes'),
    ),
  );
  }

  void _removeImage(int index) {
  setState(() {
    _multipleImageFiles.removeAt(index);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PATATAPP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null) ...[
              Image.file(
                _imageFile!,
                height: 200,
              ),
              const SizedBox(height: 20)
            ],
            if (_multipleImageFiles.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _multipleImageFiles
                      .asMap()
                      .entries
                      .map(
                        (entry) {
                          int index = entry.key;
                          File file = entry.value;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => _removeImage(index), // Eliminar imagen al tocarla
                              child: Stack(
                                children: [
                                  Image.file(
                                    file,
                                    height: 100,
                                  ),
                                  const Positioned(
                                    right: 0,
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.camera,
                );
                setState(() {});
              },
              child: const Text(
                'Capture Image from Camera',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.gallery,
                );
                setState(() {});
              },
              child: const Text(
                'Pick Image from Gallery',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.both,
                );
                setState(() {});
              },
              child: const Text(
                'Pick Image from Both',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                List<File>? selectedImages =
                    await CameraGalleryImagePicker.pickMultiImage();
                if (selectedImages.length + _multipleImageFiles.length > 4) {
                  _showLimitExceededMessage(); // Mostrar advertencia al usuario
                  return;
                }
                _multipleImageFiles.addAll(selectedImages);
                              setState(() {});
              },
              child: const Text(
                'Pick Multiple Images',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera_gallery_image_picker/camera_gallery_image_picker.dart';
import 'results_screen.dart';

class CameraGalleryImagePickerScreen extends StatefulWidget {
  const CameraGalleryImagePickerScreen({super.key});

  @override
  State<CameraGalleryImagePickerScreen> createState() =>
      _CameraGalleryImagePickerState();
}

class _CameraGalleryImagePickerState
    extends State<CameraGalleryImagePickerScreen> {
  final List<File> _multipleImageFiles = [];

  void _showLimitExceededMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No puedes seleccionar más de 5 imágenes'),
      ),
    );
  }

  Future<void> _pickImage(ImagePickerSource source) async {
    if (source == ImagePickerSource.gallery) {
      List<File>? selectedImages =
          await CameraGalleryImagePicker.pickMultiImage();

      if (selectedImages.length + _multipleImageFiles.length > 5) {
        _showLimitExceededMessage();
        return;
      }

      setState(() {
        _multipleImageFiles.addAll(selectedImages ?? []);
      });
    } else {
      File? selectedImage = await CameraGalleryImagePicker.pickImage(
        context: context,
        source: source,
      );

      if (selectedImage != null) {
        setState(() {
          if (_multipleImageFiles.length < 5) {
            _multipleImageFiles.add(selectedImage);
          } else {
            _showLimitExceededMessage();
          }
        });
      }
    }
  }

  Future<List<Map<String, dynamic>>> _uploadImages() async {
    await Future.delayed(const Duration(seconds: 2)); // Simular tiempo de carga
    return _multipleImageFiles.map((file) {
      return {
        'image': file, // Archivo de imagen local
        'percentage': Random().nextInt(101), // Porcentaje aleatorio entre 0 y 100
      };
    }).toList();
  }

  void _submitImages() async {
    if (_multipleImageFiles.isNotEmpty) {
      final results = await _uploadImages();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(results: results),
        ),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('PATATAPP'),
    ),
    body: Center( // Cambiar SingleChildScrollView por Center
      child: SingleChildScrollView( // Mantener el scroll horizontal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (_multipleImageFiles.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_multipleImageFiles.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Image.file(
                            _multipleImageFiles[index],
                            height: 75,
                            width: 75,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  _multipleImageFiles.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitImages,
                child: const Text('Subir Fotos'),
              ),
            ],
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _pickImage(ImagePickerSource.camera),
              child: const Text('Capture Image from Camera'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => _pickImage(ImagePickerSource.gallery),
              child: const Text('Pick Multiple Images from Gallery'),
            ),
          ],
        ),
      ),
    ),
  );
}
}

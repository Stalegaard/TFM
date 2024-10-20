import 'package:flutter/material.dart';
import 'screens/camera_gallery_picker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CameraGalleryImagePickerScreen(),
    );
  }
}

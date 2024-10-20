import 'dart:io';
import 'package:camera_gallery_image_picker/camera_gallery_image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerService {
  Future<File?> pickSingleImage(BuildContext context, ImagePickerSource source) async {
    return await CameraGalleryImagePicker.pickImage(
      context: context,
      source: source,
    );
  }

  Future<List<File>?> pickMultipleImages() async {
    return await CameraGalleryImagePicker.pickMultiImage();
  }
}

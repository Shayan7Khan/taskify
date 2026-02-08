import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  //pick image from gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
    return null;
  }

  //pick image from camera
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
    return null;
  }
}

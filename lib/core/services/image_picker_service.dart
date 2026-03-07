import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/core/logge_customizations/custom_logger.dart';

class ImagePickerService {
  final CustomLogger log = CustomLogger(
    className: 'Image Picker Service Class',
  );
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
      log.d('Picked Image from gallery: $image');

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      log.e('Error picking image from gallery: $e');
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
      log.d('Picked Image from camera: $image');

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      log.e('Error picking image from camera: $e');
    }
    return null;
  }
}

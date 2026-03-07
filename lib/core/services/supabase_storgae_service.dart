import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/logge_customizations/custom_logger.dart';

class SupabaseStorgaeService {
  final CustomLogger log = CustomLogger(className: 'Supabase Storage service');
  final _supabase = Supabase.instance.client;

  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    try {
      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';
      log.d('File Name = $fileName');

      //uploading to supabase
      await _supabase.storage
          .from('profile-images')
          .upload(fileName, imageFile);

      //getting the public image url
      final imageUrl = _supabase.storage
          .from('profile-images')
          .getPublicUrl(fileName);
      log.d('Image URL = $imageUrl');

      return imageUrl;
    } catch (e) {
      log.e('Error uploading image: $e');
    }
    return null;
  }
}

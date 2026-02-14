import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorgaeService {
  final _supabase = Supabase.instance.client;

  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    try {
      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';

      //uploading to supabase
      await _supabase.storage
          .from('profile-images')
          .upload(fileName, imageFile);

      //getting the public image url
      final imageUrl = _supabase.storage
          .from('profile-images')
          .getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
    }
    return null;
  }
}

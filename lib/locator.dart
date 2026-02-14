import 'package:get_it/get_it.dart';
import 'package:taskify/core/services/auth_service.dart';
import 'package:taskify/core/services/image_picker_service.dart';
import 'package:taskify/core/services/local_storage_service.dart';
import 'package:taskify/core/services/supabase_storgae_service.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(AuthService());
  locator.registerSingleton(ImagePickerService());
  locator.registerSingleton(SupabaseStorgaeService());
}

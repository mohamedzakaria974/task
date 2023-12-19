import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/utils/logger.dart';
import 'core/utils/secure_storage_util.dart';
import 'data/providers/shared_preferences.dart';
import 'routes/app_pages.dart';
import 'services/getx_services/authentication_service.dart';
import 'services/getx_services/language_service.dart';

class Initializer {
  Initializer._();

  static Future<String> initialize() async {
    await Hive.initFlutter();
    Get.put(
      SharedPreferences(
        await Hive.openBox('mainStorage'),
        await initSecuredHiveBox(),
      ),
    );
    initLogger();
    Get.put(AuthenticationService());
    Get.put(LanguageService());

    String initial = AppPages.kInitial;
    //TODO: handle multiple initial routes in [initial]
    return initial;
  }
}

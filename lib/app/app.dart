import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/utils/uni_links_util.dart';
import 'routes/app_pages.dart';
import 'services/getx_services/language_service.dart';

class App extends StatelessWidget {
  final String initialRoute;
  final languageService = Get.find<LanguageService>();

  App({super.key, required this.initialRoute}) {
    UniLinksUtil()
      ..deepLinkHandler = (link) {
        if (link?.contains('view-profile') ?? false) {
          Uri uri = Uri.parse(link!);
          Get.toNamed(Routes.kProfile, arguments: {
            'readOnly': true,
            'profile_id': uri.pathSegments[2],
          });
        }
      }
      ..initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      translations: languageService,
      locale: languageService.locale,
      fallbackLocale: languageService.fallbackLocale,
    );
  }
}

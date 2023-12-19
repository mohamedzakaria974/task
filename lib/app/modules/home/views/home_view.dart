import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_buttons.dart';
import '../../../core/values/localization/locale_keys.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: PrimaryButton(
                label: LocaleKeys.kProfile.tr,
                onPressed: () => Get.toNamed(Routes.kProfile),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: PrimaryButton(
                label: LocaleKeys.kProfile.tr,
                onPressed: () => Get.toNamed(Routes.kMyLink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

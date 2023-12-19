import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/services/getx_services/authentication_service.dart';

import '../../../core/theme/app_buttons.dart';
import '../../../core/values/localization/locale_keys.dart';
import '../controllers/my_link_controller.dart';

class MyLinkView extends GetView<MyLinkController> {
  const MyLinkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyLinkView'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: PrimaryButton(
            label: LocaleKeys.kShare.tr,
            onPressed: () {
              final authService = Get.find<AuthenticationService>();
              if (authService.currentUser?.id != null) {
                controller.onShareProfileClicked(authService.currentUser!.id!);
              }
            },
          ),
        ),
      ),
    );
  }
}

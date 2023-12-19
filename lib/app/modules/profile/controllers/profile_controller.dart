import 'package:get/get.dart';

class ProfileController extends GetxController {
  late final bool readOnly;

  @override
  void onInit() {
    readOnly = Get.arguments['readOnly'] ?? false;
    super.onInit();
  }
}

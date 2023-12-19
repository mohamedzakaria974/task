import 'package:get/get.dart';

import '../controllers/my_link_controller.dart';

class MyLinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLinkController>(
      () => MyLinkController(),
    );
  }
}

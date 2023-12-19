import 'dart:async';

import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../../data/enums/account_enum.dart';
import '../../data/models/user/user.dart';
import '../../data/providers/shared_preferences.dart';
import '../../routes/app_pages.dart';

class AuthenticationService extends GetxService {
  var status = AccountStatus.loading.obs;
  final Rx<User?> _currentUser = Rx(null);
  final _storage = Get.find<SharedPreferences>();
  final logger = Logger('AuthenticationService');

  User? get currentUser => _currentUser.value;

  int? get userId => _currentUser.value?.id;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void initAccount() {
    if (currentUser != null) {
      status.value = AccountStatus.available;
    } else {
      status.value = AccountStatus.unauthorized;
    }
  }

  Future<void> logout() async {
    try {
      Get.toNamed(Routes.kLogin);
    } catch (_) {
      logger.info('Can\'t open loading');
    }
  }
}

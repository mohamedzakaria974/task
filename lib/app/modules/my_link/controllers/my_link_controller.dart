import 'package:get/get.dart';
import 'package:task/app/core/utils/share_util.dart';

class MyLinkController extends GetxController {
  Future<void> onShareProfileClicked(int profileId) async {
    String shareText =
        'Hey bro, Check out my profile: https://www.example.com/view-profile/$profileId';
    await DefaultShareUtil().shareText(shareText);
  }
}

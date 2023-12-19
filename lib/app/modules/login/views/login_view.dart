import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_buttons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/values/localization/locale_keys.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: Container(
          color: Colors.transparent,
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: SafeArea(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            LocaleKeys.kWelcome.tr,
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            LocaleKeys.kLogin.tr,
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.kEmail.tr,
                          suffixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.kPassword.tr,
                          suffixIcon: const Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 8.0, start: 8.0),
                          child: Text(
                            LocaleKeys.kForgotPassword.tr,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              label: LocaleKeys.kLogin.tr,
                              onPressed: () => Get.offAllNamed(Routes.kHome),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text.rich(
                        TextSpan(
                            text: LocaleKeys.kDoNotHaveAccount.tr,
                            children: [
                              TextSpan(
                                text: LocaleKeys.kSignUp.tr,
                                style: const TextStyle(color: AppColors.orange),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.toNamed(Routes.kSignUp),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

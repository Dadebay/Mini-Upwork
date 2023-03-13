// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/constants/constants.dart';

import '../../../constants/buttons/agree_button.dart';
import '../../../constants/textFields/phone_number.dart';
import '../controllers/sign_in_page_controller.dart';

class LogInView extends GetView {
  TextEditingController fullNameController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final login = GlobalKey<FormState>();
  final SignInPageController signInPageController = Get.put(SignInPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: login,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
              child: Text(
                'signInDialog'.tr,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: PhoneNumber(
                mineFocus: phoneNumberFocusNode,
                controller: phoneNumberController,
                requestFocus: emailFocusNode,
              ),
            ),
            Center(
              child: AgreeButton(
                onTap: () {
                  signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

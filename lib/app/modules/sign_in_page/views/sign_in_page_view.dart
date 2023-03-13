// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/constants/constants.dart';
import 'package:maksat_app/app/constants/textFields/custom_text_field.dart';
import 'package:maksat_app/app/constants/textFields/phone_number.dart';

import '../../../constants/buttons/agree_button.dart';
import '../controllers/sign_in_page_controller.dart';

class SignInView extends GetView {
  TextEditingController fullNameController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  TextEditingController idController = TextEditingController();
  FocusNode idFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final _signUp = GlobalKey<FormState>();
  final SignInPageController signInPageController = Get.put(SignInPageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Form(
        key: _signUp,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 14, top: 12),
                child: Text(
                  'signInDialog'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
                ),
              ),
              CustomTextField(labelName: 'signIn1', controller: fullNameController, focusNode: fullNameFocusNode, requestfocusNode: idFocusNode, borderRadius: true, isNumber: false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(labelName: 'signIn2', controller: idController, focusNode: idFocusNode, requestfocusNode: phoneNumberFocusNode, borderRadius: true, isNumber: false),
              ),
              PhoneNumber(
                mineFocus: phoneNumberFocusNode,
                controller: phoneNumberController,
                requestFocus: fullNameFocusNode,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: AgreeButton(
                  onTap: () {
                    signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

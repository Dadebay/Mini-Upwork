// ignore_for_file: deprecated_member_use, file_names, depend_on_referenced_packages, avoid_void_async, always_declare_return_types, type_annotate_public_apis, unnecessary_statements, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/textFields/phone_number.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:maksat_app/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../constants/buttons/agree_button.dart';
import '../../../constants/constants.dart';
import '../../../constants/textFields/custom_text_field.dart';
import '../../../constants/widgets.dart';

class Page3 extends StatefulWidget {
  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  Widget type1({required String name, required TextEditingController controller, required FocusNode focusNode, required FocusNode requestFocus, required int maxline}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.tr,
            style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
          CustomTextField(
            validate: true,
            labelName: '',
            borderRadius: true,
            controller: controller,
            focusNode: focusNode,
            requestfocusNode: requestFocus,
            isNumber: false,
            maxline: maxline,
          ),
        ],
      ),
    );
  }

  final validator = GlobalKey<FormState>();
  final UserProfilController userProfilController = Get.put(UserProfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          width: Get.size.width,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "aboutYou".tr,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
            ),
            Text(
              "aboutYouSubtitle".tr,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.red, fontFamily: gilroyMedium, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Form(
              key: validator,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  type1(controller: nameController, focusNode: nameFocusNode, name: 'userName', requestFocus: phoneFocusNode, maxline: 1),
                  Text(
                    'phoneNumber'.tr,
                    style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                  ),
                  PhoneNumber(mineFocus: phoneFocusNode, controller: phoneNumberController, requestFocus: descFocusNode),
                  SizedBox(
                    height: 30,
                  ),
                  type1(controller: descController, focusNode: descFocusNode, name: 'note', requestFocus: nameFocusNode, maxline: 4),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: AgreeButton(
                  onTap: () async {
                    if (userProfilController.agreeButton.value == false) {
                      userProfilController.agreeButton.value = !userProfilController.agreeButton.value;
                      if (validator.currentState!.validate()) {
                        final response = await http.post(
                          Uri.parse('$serverURL/api/create-order'),
                          headers: <String, String>{
                            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode({
                            "name": nameController.text,
                            "phone": phoneNumberController.text,
                            "description": descController.text,
                            "category_id": homeController.selectedCategoryID.value,
                            'specs': homeController.selectedList,
                          }),
                        );
                        print(response.body);
                        if (response.statusCode == 200) {
                          final responseJson = jsonDecode(response.body);
                          userProfilController.agreeButton.value = !userProfilController.agreeButton.value;
                          userProfilController.addOrderId(id: responseJson['id'].toString());
                          homeController.incrementPageIndex();
                        } else {
                          showSnackBar('noConnection3', 'noConnection4', Colors.red);
                          userProfilController.agreeButton.value = !userProfilController.agreeButton.value;
                        }
                      } else {
                        showSnackBar('noConnection3', 'errorData', Colors.red);
                        userProfilController.agreeButton.value = !userProfilController.agreeButton.value;
                      }
                    } else {
                      showSnackBar('noConnection3', 'noConnection4', Colors.red);
                    }
                  },
                ),
              ),
            )
          ])),
    );
  }
}

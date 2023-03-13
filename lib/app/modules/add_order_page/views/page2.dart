import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/buttons/agree_button.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';
import 'package:maksat_app/app/constants/textFields/phone_number.dart';

import '../../../constants/constants.dart';
import '../../../constants/textFields/custom_text_field.dart';

class Page2 extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNode = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ordersList').doc(homeController.documentID.value).collection('questions').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasError) {
            return Center(
                child: Text(
              "noData1".tr,
              style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
            ));
          } else if (streamSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "noData".tr,
                style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
              ),
            );
          }
          if (_focusNode.length < streamSnapshot.data!.docs.length) {
            _focusNode.add(FocusNode());
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return textField(streamSnapshot, index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AgreeButton(onTap: () {
                  homeController.incrementPageIndex();
                }),
              )
            ],
          );
        });
  }

  Padding textField(AsyncSnapshot<QuerySnapshot<Object?>> streamSnapshot, int index) {
    if (_controllers.length < streamSnapshot.data!.docs.length) {
      _controllers.add(TextEditingController());
    }
    if (_focusNode.length <= streamSnapshot.data!.docs.length) {
      _focusNode.add(FocusNode());
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Get.locale!.languageCode.toString() == 'tr' ? streamSnapshot.data!.docs[index]['questionTm'].toString() : streamSnapshot.data!.docs[index]['questionRu'].toString(),
            style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
          streamSnapshot.data!.docs[index]['isPhoneNumber']
              ? PhoneNumber(
                  mineFocus: _focusNode[index],
                  controller: _controllers[index],
                  requestFocus: _focusNode[index + 1],
                )
              : CustomTextField(labelName: '', borderRadius: true, controller: _controllers[index], focusNode: _focusNode[index], requestfocusNode: _focusNode[index + 1], isNumber: streamSnapshot.data!.docs[index]['isNumber']),
        ],
      ),
    );
  }
}

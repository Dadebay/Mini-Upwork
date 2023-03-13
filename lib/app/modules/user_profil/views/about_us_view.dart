import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/custom_app_bar.dart';
import '../../../constants/widgets.dart';

class AboutUsView extends GetView {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'aboutUS'),
        body: customWidget(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('aboutUS').snapshots(),
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
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'contactInformation'.tr,
                          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                        ),
                      ),
                      Text(
                        streamSnapshot.data!.docs[0]['contactUS'],
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}

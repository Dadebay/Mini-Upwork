import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/constants/custom_app_bar.dart';
import 'package:maksat_app/app/constants/widgets.dart';

import '../../../constants/constants.dart';

class FAQ extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'questions'),
      body: customWidget(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('questions').snapshots(),
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
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    tilePadding: EdgeInsets.only(top: 8, left: 14, right: 14),
                    title: Text(
                      streamSnapshot.data!.docs[index]['questionTitle'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: gilroySemiBold,
                        fontSize: 18,
                      ),
                    ),
                    collapsedIconColor: Colors.black,
                    iconColor: Colors.black,
                    childrenPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 12),
                    children: [
                      Text(
                        streamSnapshot.data!.docs[index]['questionSubtitle'],
                        style: const TextStyle(color: Colors.black45, fontSize: 16, height: 1.5, fontFamily: gilroyRegular),
                      )
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}

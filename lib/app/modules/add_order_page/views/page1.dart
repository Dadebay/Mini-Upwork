// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/constants.dart';
import 'package:maksat_app/app/constants/widgets.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';

class Page1 extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          width: Get.size.width,
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Text(
            "selectType".tr,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
          ),
        ),
        Divider(
          color: Colors.grey.shade100,
          thickness: 1,
        ),
        Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('ordersList').snapshots(),
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
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          homeController.documentID.value = streamSnapshot.data!.docs[index].id;
                          homeController.incrementPageIndex();
                        },
                        minVerticalPadding: 0.0,
                        title: Text(
                          Get.locale!.languageCode == 'tr' ? streamSnapshot.data!.docs[index]['orderNameTm'] : streamSnapshot.data!.docs[index]['orderNameRu'],
                          style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                        ),
                        trailing: Icon(
                          IconlyLight.arrowRightCircle,
                          color: Colors.black,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return divider();
                    },
                  );
                })),
      ],
    );
  }
}

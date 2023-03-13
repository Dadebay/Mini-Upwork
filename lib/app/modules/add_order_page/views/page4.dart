import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/buttons/agree_button.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/constants.dart';

class Page4 extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  var collection = FirebaseFirestore.instance.collection('ordersList');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: collection.doc(homeController.documentID.value).snapshots(),
        builder: (_, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasError) {
            return Center(
                child: Text(
              "noData1".tr,
              style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
            ));
          } else if (streamSnapshot.data == null) {
            return Center(
              child: Text(
                "noData".tr,
                style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35, bottom: 25),
                  child: Text(
                    'Etmeli iş barada maglumat :',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Işiň jemi bahasy :',
                      style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                    ),
                    Text(
                      streamSnapshot.data!['money'] + ' TMT',
                      style: TextStyle(fontFamily: gilroySemiBold, fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Etmeli iş',
                        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                      ),
                      Text(
                        'Elektron kitap',
                        style: TextStyle(fontFamily: gilroySemiBold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ýetişdirmeli wagty: ',
                      style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                    ),
                    Text(
                      '24.02.1823',
                      style: TextStyle(fontFamily: gilroySemiBold, fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Töleg geçirmeli belgi: ',
                        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                      ),
                      Text(
                        '+99362990344',
                        style: TextStyle(fontFamily: gilroySemiBold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  'Töleg geçenden soň zakaz kabul edilmedik ýagdaýynda tölegiňiz. Siziň nomeriňize yzyna  gaýtarylar',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AgreeButton(onTap: () async {
                    String phoneNumber = "";
                    await FirebaseFirestore.instance.collection('phoneNumbers').get().then((value) {
                      phoneNumber = value.docs[0]['phoneNumber1'];
                    });

                    if (Platform.isAndroid) {
                      final uri = 'sms:0804?body=${phoneNumber}   ${streamSnapshot.data!['money']} ';
                      await launchUrlString(uri);
                    } else if (Platform.isIOS) {
                      final uri = 'sms:0804&body=${phoneNumber}   ${streamSnapshot.data!['money']} ';
                      await launchUrlString(uri);
                    }
                    // homeController.incrementPageIndex();
                  }),
                )
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maksat_app/app/constants/buttons/agree_button.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';

import '../../../constants/constants.dart';

class Page4 extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Lottie.asset('assets/lottie/done.json', width: 400, height: 400)),
          Text(
            'orderConfirmed'.tr,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'orderConfirmedSubtitle'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AgreeButton(onTap: () async {
              Get.back();
            }),
          )
        ],
      ),
    );
    ;
  }
}

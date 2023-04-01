import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/data/models/aboust_us_model.dart';

import '../../../constants/constants.dart';
import '../../../constants/custom_app_bar.dart';
import '../../../constants/error_widgets/empty_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/services/get_user_data.dart';

class AboutUsView extends GetView {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'aboutUS'),
        body: customWidget(
          child: FutureBuilder<AboutUsModel>(
              future: GetUserData().getAboutUs(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return spinKit();
                } else if (streamSnapshot.hasError) {
                  return errorPage();
                } else if (streamSnapshot.data == null) {
                  return emptyPage();
                }
                return Container(
                  width: Get.size.width,
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                        streamSnapshot.data!.aboutUs!,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 18, fontFamily: gilroyMedium, color: Colors.black),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}

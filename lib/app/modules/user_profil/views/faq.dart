import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/constants/custom_app_bar.dart';
import 'package:maksat_app/app/constants/widgets.dart';
import 'package:maksat_app/app/data/models/aboust_us_model.dart';

import '../../../constants/constants.dart';
import '../../../constants/error_widgets/empty_widgets.dart';
import '../../../data/services/get_user_data.dart';

class FAQ extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'questions'),
      body: customWidget(
        child: FutureBuilder<List<FaqModel>>(
            future: GetUserData().getFAQ(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return spinKit();
              } else if (streamSnapshot.hasError) {
                return errorPage();
              } else if (streamSnapshot.data == null) {
                return emptyPage();
              }
              return ListView.builder(
                itemCount: streamSnapshot.data!.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    tilePadding: EdgeInsets.only(top: 8, left: 14, right: 14),
                    title: Text(
                      streamSnapshot.data![index].question!,
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
                        streamSnapshot.data![index].answer!,
                        textAlign: TextAlign.start,
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

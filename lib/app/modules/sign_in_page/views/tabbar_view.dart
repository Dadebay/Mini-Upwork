import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/modules/sign_in_page/views/sign_in_page_view.dart';

import '../../../constants/constants.dart';
import 'login_view.dart';

class TabbarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              IconlyLight.arrowLeftCircle,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        ),
        body: Stack(
          children: [
            logoDesign(),
            SingleChildScrollView(
              child: SizedBox(
                height: Get.size.height - kToolbarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 8),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          indicatorColor: Colors.red,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 22),
                          unselectedLabelStyle: const TextStyle(fontFamily: gilroyRegular),
                          labelColor: Colors.white,
                          indicatorWeight: 4,
                          indicatorPadding: const EdgeInsets.only(top: 45),
                          indicator: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              text: 'signUp'.tr,
                            ),
                            Tab(
                              text: 'login'.tr,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TabBarView(children: [SignInView(), LogInView()]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox logoDesign() {
    return SizedBox(
      width: Get.size.width,
      height: Get.size.height / 2.8,
      child: ClipRRect(
        borderRadius: borderRadius50,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius50,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              logo,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

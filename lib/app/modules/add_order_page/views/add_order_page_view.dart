import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/modules/add_order_page/views/page1.dart';
import 'package:maksat_app/app/modules/add_order_page/views/page2.dart';
import 'package:maksat_app/app/modules/add_order_page/views/page3.dart';
import 'package:maksat_app/app/modules/add_order_page/views/page4.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../constants/constants.dart';

class AddOrderPageView extends StatefulWidget {
  @override
  _AddOrderPageViewState createState() => _AddOrderPageViewState();
}

class _AddOrderPageViewState extends State<AddOrderPageView> {
  final HomeController bottomNavBarController = Get.put(HomeController());

  List page = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];

  Widget progressIndicator() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 45, left: 15, right: 15, bottom: 15),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  bottomNavBarController.selectedPageIndex.value >= 1 ? bottomNavBarController.dicrementPageIndex() : Get.back();
                },
                child: Obx(() {
                  print(bottomNavBarController.selectedPageIndex.value);
                  return bottomNavBarController.selectedPageIndex.value >= 3
                      ? const SizedBox.shrink()
                      : const Icon(
                          IconlyLight.arrowLeftCircle,
                          color: kPrimaryColor,
                          size: 25,
                        );
                }),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  bottomNavBarController.selectedPageIndex.value = 0;
                },
                child: Text(
                  "close".tr,
                  style: const TextStyle(color: kPrimaryColor, fontFamily: gilroyMedium),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StepProgressIndicator(
            totalSteps: page.length,
            currentStep: bottomNavBarController.selectedPageIndex.value + 1,
            size: 8,
            customStep: (index, color, size) {
              return Container(
                width: 25,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(borderRadius: borderRadius5, color: color),
              );
            },
            selectedColor: kPrimaryColor,
            unselectedColor: Colors.grey.shade200,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return Column(
            children: [progressIndicator(), Expanded(child: page[bottomNavBarController.selectedPageIndex.value] as Widget)],
          );
        }));
  }
}

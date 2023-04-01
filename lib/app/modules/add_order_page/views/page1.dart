// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/constants.dart';
import 'package:maksat_app/app/constants/error_widgets/empty_widgets.dart';
import 'package:maksat_app/app/constants/widgets.dart';
import 'package:maksat_app/app/data/models/category_model.dart';
import 'package:maksat_app/app/data/services/category_services.dart';
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
            child: FutureBuilder<List<CategoryModel>>(
                future: CategoryServices().getCategories(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: spinKit());
                  } else if (streamSnapshot.hasError) {
                    return errorPage();
                  } else if (streamSnapshot.data!.isEmpty) {
                    return emptyPage();
                  }
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: streamSnapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          homeController.selectedList.clear();
                          homeController.incrementPageIndex();
                          homeController.selectedCategoryID.value = streamSnapshot.data![index].id!;
                        },
                        minVerticalPadding: 0.0,
                        title: Text(
                          streamSnapshot.data![index].name!,
                          style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
                        ),
                        subtitle: Text(
                          'minPrice'.tr + ' - ' + streamSnapshot.data![index].minPrice! + ' m',
                          style: TextStyle(color: Colors.grey, fontFamily: gilroyMedium, fontSize: 14),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/constants.dart';
import 'package:maksat_app/app/constants/custom_app_bar.dart';

import '../../../constants/error_widgets/empty_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/banner_model.dart';
import '../../../data/services/banner_service.dart';
import 'banner_profile_view.dart';

class OurServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'ourServices'),
      body: FutureBuilder<List<BannerModel>>(
          future: BannerService().getWorks(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (streamSnapshot.hasError) {
              return Container(
                width: Get.size.width,
                height: Get.size.height,
                color: Colors.white,
                child: errorPage(),
              );
            } else if (streamSnapshot.data!.isEmpty) {
              return Container(
                width: Get.size.width,
                color: Colors.white,
                height: Get.size.height,
                child: emptyPage(),
              );
            }
            return customWidget(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: streamSnapshot.data!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => BannerProfileView(streamSnapshot.data![index].id!));
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey.shade300, boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 3, blurRadius: 3)], borderRadius: borderRadius30),
                      child: CachedNetworkImage(
                        fadeInCurve: Curves.ease,
                        imageUrl: '$serverURL/${streamSnapshot.data![index].destination!}-mini.webp',
                        imageBuilder: (context, imageProvider) => Container(
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            borderRadius: borderRadius30,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: spinKit()),
                        errorWidget: (context, url, error) => Center(
                          child: noBannerImage(),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.count(1, index % 2 == 0 ? 1.5 : 1.3),
              ),
            );
          }),
    );
  }
}

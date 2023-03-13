import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/cards/banner_card.dart';
import '../../../constants/constants.dart';
import '../../../constants/error_widgets/empty_widgets.dart';
import '../../../constants/error_widgets/error_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/banner_model.dart';
import '../controllers/home_controller.dart';

class BannersView extends GetView {
  final Future<List<BannerModel>> future;
  final HomeController bannerController = Get.put(HomeController());

  BannersView(this.future);
  Container dots(int length) {
    return Container(
      height: 4,
      margin: EdgeInsets.only(top: 4),
      width: Get.size.width,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              return dot(index);
            });
          },
        ),
      ),
    );
  }

  AnimatedContainer dot(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(left: 4, right: 4),
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      height: 16,
      width: 18,
      decoration: BoxDecoration(
        color: bannerController.bannerDotsIndex.value == index ? kPrimaryColor : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
        future: future,
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.2)), child: Center(child: spinKit()));
          } else if (streamSnapshot.hasError) {
            return bannerErrorWidget();
          } else if (streamSnapshot.data!.isEmpty) {
            return bannerEmptyWidget();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider.builder(
                itemCount: streamSnapshot.data!.length,
                itemBuilder: (context, index, count) {
                  return BannerCard(
                    image: '$serverURL/${streamSnapshot.data![index].destination!}-mini.webp',
                    id: streamSnapshot.data![index].id!,
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, CarouselPageChangedReason a) {
                    bannerController.bannerDotsIndex.value = index;
                  },
                  height: 220,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                ),
              ),
              dots(streamSnapshot.data!.length)
            ],
          );
        });
  }
}

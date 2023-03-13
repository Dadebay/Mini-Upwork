import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/constants/buttons/profile_button.dart';
import 'package:maksat_app/app/constants/constants.dart';
import 'package:maksat_app/app/constants/widgets.dart';
import 'package:maksat_app/app/modules/home/views/banners_view.dart';
import 'package:maksat_app/app/modules/home/views/our_services.dart';
import 'package:maksat_app/app/modules/user_profil/views/user_profil_view.dart';

import '../../../data/models/banner_model.dart';
import '../../../data/services/banner_service.dart';
import '../../add_order_page/views/add_order_page_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());
  late Future<List<BannerModel>> bannersFuture;
  late Future<List<BannerModel>> getWorks;
  @override
  void initState() {
    super.initState();
    bannersFuture = BannerService().getBanners();
    getWorks = BannerService().getWorks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: appBar(),
        body: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
            child: ListView(
              children: [
                BannersView(bannersFuture),
                GestureDetector(
                  onTap: () {
                    homeController.selectedPageIndex.value = 0;
                    Get.to(() => AddOrderPageView());
                  },
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 8),
                    decoration: BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius40),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "addService".tr,
                            style: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 28),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => OurServices(future: getWorks,));
                  },
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius40),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "ourServices".tr,
                            style: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 28),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            defaultBottomSheet(
                name: 'call',
                child: Column(
                  children: [
                    ProfilButton(
                      name: '+99362990344',
                      onTap: () {},
                      icon: IconlyLight.call,
                      langIconStatus: false,
                    ),
                    ProfilButton(
                      name: '+99365139447',
                      onTap: () {},
                      icon: IconlyLight.call,
                      langIconStatus: false,
                    ),
                  ],
                ));
          },
          icon: Icon(
            IconlyLight.call,
            color: Colors.white,
          )),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => UserProfilView());
            },
            icon: Icon(
              IconlyBold.setting,
              color: Colors.white,
            ))
      ],
      title: Text(
        'home'.tr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: gilroyMedium,
          fontSize: 22,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/buttons/profile_button.dart';
import 'package:maksat_app/app/constants/constants.dart';
import 'package:maksat_app/app/constants/widgets.dart';
import 'package:maksat_app/app/modules/home/views/banners_view.dart';
import 'package:maksat_app/app/modules/home/views/our_services.dart';
import 'package:maksat_app/app/modules/user_profil/views/user_profil_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/error_widgets/empty_widgets.dart';
import '../../../data/models/aboust_us_model.dart';
import '../../../data/models/banner_model.dart';
import '../../../data/services/banner_service.dart';
import '../../../data/services/get_user_data.dart';
import '../../add_order_page/views/add_order_page_view.dart';
import '../../user_profil/views/history_orders.dart';
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
        body: customWidget(
          child: ListView(
            children: [
              BannersView(bannersFuture),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  button('homePage1', CupertinoIcons.add_circled, () {
                    homeController.selectedPageIndex.value = 0;
                    Get.to(() => AddOrderPageView());
                  }),
                  button("homePage2", IconlyLight.discovery, () {
                    Get.to(() => OurServices(future: getWorks));
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  button('homePage3', IconlyLight.profile, () {
                    Get.to(() => UserProfilView());
                  }),
                  button("homePage4", IconlyLight.document, () {
                    Get.to(() => HistoryOrders());
                  }),
                ],
              ),
            ],
          ),
        ));
  }

  Expanded button(String name, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: borderRadius30, side: BorderSide(color: Colors.grey.shade300, width: 2)),
              elevation: 0,
              padding: EdgeInsets.all(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Icon(
                    icon,
                    size: 60,
                  ),
                ),
                Text(
                  name.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 17),
                )
              ],
            )),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      leading: IconButton(
          onPressed: () {
            defaultBottomSheet(
                name: 'call',
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
                      return Column(
                        children: [
                          ProfilButton(
                            name: streamSnapshot.data!.phone1!,
                            onTap: () {
                              launchUrlString("tel://${streamSnapshot.data!.phone1!}");
                            },
                            icon: IconlyLight.call,
                            langIconStatus: false,
                          ),
                          ProfilButton(
                            name: streamSnapshot.data!.phone2!,
                            onTap: () {
                              launchUrlString("tel://${streamSnapshot.data!.phone2!}");
                            },
                            icon: IconlyLight.call,
                            langIconStatus: false,
                          ),
                        ],
                      );
                    }));
          },
          icon: Icon(
            IconlyLight.call,
            color: Colors.white,
          )),
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

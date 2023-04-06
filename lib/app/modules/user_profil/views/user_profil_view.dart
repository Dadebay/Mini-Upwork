import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/constants/custom_app_bar.dart';
import '../../../constants/buttons/profile_button.dart';
import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../controllers/user_profil_controller.dart';
import 'about_us_view.dart';
import 'faq.dart';

class UserProfilView extends StatefulWidget {
  @override
  State<UserProfilView> createState() => _UserProfilViewState();
}

class _UserProfilViewState extends State<UserProfilView> {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'settings'),
      body: page(),
    );
  }

  Widget page() {
    return customWidget(
      child: ListView(
        children: [
          ProfilButton(
            name: Get.locale!.toLanguageTag() == 'tr'
                ? 'Türkmen dili'
                : Get.locale!.toLanguageTag() == 'ru'
                    ? 'Rus dili'
                    : 'Inlis dili',
            onTap: () {
              changeLanguage();
            },
            icon: CupertinoIcons.add,
            langIconStatus: true,
            langIcon: Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.only(top: 3),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: ClipRRect(
                borderRadius: borderRadius15,
                child: Image.asset(
                  Get.locale!.toLanguageTag() == 'tr' ? tmIcon : ruIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ProfilButton(
            name: 'questions',
            onTap: () {
              Get.to(() => FAQ());
            },
            icon: IconlyLight.document,
            langIconStatus: false,
          ),
          ProfilButton(
            name: 'aboutUs',
            onTap: () {
              Get.to(() => const AboutUsView());
            },
            icon: IconlyLight.user3,
            langIconStatus: false,
          ),
        ],
      ),
    );
  }
}

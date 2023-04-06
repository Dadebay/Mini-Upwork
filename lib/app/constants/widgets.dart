import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../modules/user_profil/controllers/user_profil_controller.dart';
import 'constants.dart';

dynamic noBannerImage() {
  return Center(child: Text('noImage'.tr));
}

dynamic spinKit() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: CircularProgressIndicator(
        color: kPrimaryColor,
      ),
    ),
  );
}

dynamic customWidget({required Widget child}) {
  return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))), child: child));
}

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  SnackbarController.cancelAllSnackbars();
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontFamily: gilroyRegular, fontSize: 16, color: Colors.white),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    borderRadius: 20.0,
    animationDuration: const Duration(milliseconds: 500),
    margin: const EdgeInsets.all(8),
  );
}

Container divider() {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    child: Divider(
      color: kPrimaryColor.withOpacity(0.2),
      thickness: 1,
    ),
  );
}

void changeLanguage() {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(color: Colors.white),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  'select_language'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                )
              ],
            ),
          ),
          divider(),
          ListTile(
            onTap: () {
              userProfilController.switchLang('tr');
              Get.back();
            },
            leading: const CircleAvatar(
              backgroundImage: AssetImage(
                tmIcon,
              ),
              backgroundColor: Colors.black,
              radius: 20,
            ),
            title: const Text(
              'Türkmen',
              style: TextStyle(color: Colors.black),
            ),
          ),
          divider(),
          ListTile(
            onTap: () {
              userProfilController.switchLang('ru');
              Get.back();
            },
            leading: const CircleAvatar(
              backgroundImage: AssetImage(
                ruIcon,
              ),
              radius: 20,
              backgroundColor: Colors.black,
            ),
            title: const Text(
              'Русский',
              style: TextStyle(color: Colors.black),
            ),
          ),
          divider(),
          ListTile(
            onTap: () {
              userProfilController.switchLang('ru');
              Get.back();
            },
            leading: const CircleAvatar(
              backgroundImage: AssetImage(
                engIcon,
              ),
              radius: 20,
              backgroundColor: Colors.black,
            ),
            title: const Text(
              'English',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}

CustomFooter footer() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text('Garasyn...');
      } else if (mode == LoadStatus.loading) {
        body = const CircularProgressIndicator(
          color: kPrimaryColor,
        );
      } else if (mode == LoadStatus.failed) {
        body = const Text('Load Failed!Click retry!');
      } else if (mode == LoadStatus.canLoading) {
        body = const Text('');
      } else {
        body = const Text('No more Data');
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

Padding textpart(String name, bool value) {
  return Padding(
    padding: EdgeInsets.only(left: 8, top: value ? 15 : 30),
    child: Text(
      name.tr,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 18, color: Colors.black, fontFamily: gilroyMedium),
    ),
  );
}

void defaultBottomSheet({required String name, required Widget child}) {
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  name.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Center(
            child: child,
          )
        ],
      ),
    ),
  );
}

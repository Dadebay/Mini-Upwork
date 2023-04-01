import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProfilController extends GetxController {
  final storage = GetStorage();
  RxBool agreeButton = false.obs;
  RxList list = [].obs;
  addOrderId({required String id}) async {
    list.add(id);
    list.refresh();
    final String jsonString = jsonEncode(list);
    await storage.write('orderList', jsonString);
  }

  returnList() {
    list.clear();
    final result = storage.read('orderList') ?? '[]';
    final List jsonData = jsonDecode(result);
    if (jsonData.isEmpty) {
    } else {
      for (final element in jsonData) {
        list.add(element);
      }
    }
  }

  var tm = const Locale(
    'tr',
  );
  var ru = const Locale(
    'ru',
  );
  var en = const Locale(
    'en',
  );

  dynamic switchLang(String value) {
    if (value == 'en') {
      Get.updateLocale(en);
      storage.write('langCode', 'en');
    } else if (value == 'ru') {
      Get.updateLocale(ru);
      storage.write('langCode', 'ru');
    } else {
      Get.updateLocale(tm);
      storage.write('langCode', 'tr');
    }
    update();
  }
}

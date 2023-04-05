import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProfilController extends GetxController {
  GetStorage storage = GetStorage();
  RxBool agreeButton = false.obs;
  RxList dataSaveList = [].obs;
  addOrderId({required String id}) async {
    dataSaveList.add(id);
    final String jsonString = jsonEncode(dataSaveList);
    await storage.write('orderList', jsonString);
  }

  dynamic returnList() {
    final result2 = storage.read('langCode') ?? '[]';
    final result = storage.read('orderList') ?? '[]';
    print(result);
    final List jsonData = jsonDecode(result);
    if (jsonData.isEmpty) {
    } else {
      for (final element in jsonData) {
        if (dataSaveList.contains(element) == false) dataSaveList.add(element);
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

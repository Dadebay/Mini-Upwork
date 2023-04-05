import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maksat_app/app/constants/constants.dart';

import 'app/modules/user_profil/controllers/user_profil_controller.dart';
import 'app/modules/user_profil/views/connection_check.dart';
import 'app/constants/main_helper.dart';
import 'app/constants/utils/translations.dart';

Future<void> main() async {
  mainDartImports();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();
  final UserProfilController userProfilController = Get.put(UserProfilController());

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {});
    myAppOnInit();

    userProfilController.returnList();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ýitigöreç',
      useInheritedMediaQuery: true,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: gilroyRegular,
        colorSchemeSeed: kPrimaryColor,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          shadowColor: kPrimaryColor,
        ),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent.withOpacity(0)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      fallbackLocale: const Locale('tr'),
      locale: storage.read('langCode') != null
          ? Locale(storage.read('langCode'))
          : const Locale(
              'tr',
            ),
      translations: MyTranslations(),
      defaultTransition: Transition.fade,
      home: ConnectionCheckpage(),
      // home: MainScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maksat_app/app/constants/constants.dart';

import 'app/modules/sign_in_page/views/connection_check.dart';
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
  @override
  void initState() {
    super.initState();
    myAppOnInit();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yaka',
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

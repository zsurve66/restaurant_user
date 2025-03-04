import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:restaurant_user/app/services/firestore_service.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await _doInitForApplication();
  runApp(
    GetMaterialApp(
      title: "Restaurant App For Users",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> _doInitForApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  Get.put(FirestoreService());
}

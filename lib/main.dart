import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page/views/buyers/authorization/login_screen.dart';

import 'Vendors/views/vendor_screens/main_vendor_screen.dart';
import 'controllers/banner_controller.dart';
import 'controllers/category_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBYsNxA7PIAsAcBajHIDRsUzTNyLuUR09k",
        appId: "1:298702164343:android:1e24a85b8424171c879172",
        messagingSenderId: "298702164343",
        projectId: "multi-sotore-app-v2",
        storageBucket: "gs://multi-sotore-app-v2.appspot.com"
    )
  ) : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: LoginScreen(),
      initialBinding: BindingsBuilder((){
        Get.put<CategoryController>(CategoryController());
        Get.put<BannerController>(BannerController());
      }),
    );
  }
}
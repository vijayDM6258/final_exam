import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Views/homepage/homepage.dart';
import 'Views/splashpage/splash_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Final Exam Recipe App",
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => SplashPage(),
        ),
        GetPage(
          name: "/home_page",
          page: () => HomePage(),
        ),
      ],
    ),
  );
}

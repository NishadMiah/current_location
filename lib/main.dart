import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_location/route/app_route.dart';
import 'package:offline_location/route/depandency.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Offline',
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
      initialBinding: DependencyInjection(),
    );
  }
}

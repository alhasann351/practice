import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/resource/route/app_route.dart';

void main() {
  runApp(
    const MyApp(),
    /*DevicePreview(
      enabled: !const bool.fromEnvironment('dart.vm.product'),
      builder: (BuildContext context) => const MyApp(),
    ),*/
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //locale: DevicePreview.locale(context),
      //builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.appRoutes(),
    );
  }
}

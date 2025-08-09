import 'dart:async';

import 'package:get/get.dart';

import '../../resource/route/route_name.dart';

class SplashServices {
  void splashScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offAllNamed(RouteName.apiExampleScreen);
  }
}

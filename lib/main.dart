import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/resource/route/app_route.dart';

// Top-level function, jeta Isolate-er moddhe kaj korbe
/*@pragma('vm:entry-point')
void alarmCallback(int id, Map<String, dynamic>? params) {
  final prayerName = params?['prayer'] ?? 'Prayer';
  print('$prayerName namajer somoy hoyeche! (ID: $id)');
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
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

import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../model/prayer_time_model.dart';
import '../repository/prayer_time_service.dart';

class PrayerTimeController extends GetxController {
  final prayerTimes = Rx<PrayerTime?>(null);
  final isLoading = true.obs;
  final locationError = ''.obs;

  final isAlarmSet = <String, bool>{
    'Fajr': false,
    'Dhuhr': false,
    'Asr': false,
    'Maghrib': false,
    'Isha': false,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      isLoading.value = true;
      locationError.value = '';

      Position position = await _determinePosition();
      final service = PrayerTimeService();
      final times = await service.getPrayerTimes(
        position.latitude,
        position.longitude,
      );
      prayerTimes.value = times;
    } catch (e) {
      locationError.value = e.toString();
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return Future.error(
        'Location permissions are permanently denied. Please enable them from settings.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  void toggleAlarm(String prayerName, String prayerTime) async {
    if (isAlarmSet[prayerName] == true) {
      await _cancelAlarmForPrayer(prayerName);
    } else {
      await _setAlarmForPrayer(prayerName, prayerTime);
    }
  }

  Future<void> _setAlarmForPrayer(String name, String time) async {
    DateTime alarmTime;

    // Test-er jonno Fajr alarm 30 second por baje
    if (name == 'Fajr') {
      alarmTime = DateTime.now().add(const Duration(seconds: 30));
    } else {
      // Baki prayer-gulo shudhu time onojayi set hobe
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final now = DateTime.now();
      alarmTime = DateTime(now.year, now.month, now.day, hour, minute);

      if (alarmTime.isBefore(now)) {
        alarmTime = alarmTime.add(const Duration(days: 1));
      }
    }

    final alarmSettings = AlarmSettings(
      id: name.hashCode,
      dateTime: alarmTime,
      assetAudioPath: 'assets/ring.mp3',
      loopAudio: true,
      vibrate: true,
      //warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      volumeSettings: VolumeSettings.fade(
        volume: 0.8,
        fadeDuration: const Duration(seconds: 5),
        volumeEnforced: true,
      ),
      notificationSettings: const NotificationSettings(
        title: 'This is the title',
        body: 'This is the body',
        stopButton: 'Stop the alarm',
        icon: 'notification_icon',
        iconColor: Color(0xff862778),
      ),
    );

    try {
      await Alarm.set(alarmSettings: alarmSettings);
      isAlarmSet[name] = true;
      print('$name alarm set for $alarmTime');
    } catch (e) {
      print('Failed to set alarm: $e');
    }
  }

  Future<void> _cancelAlarmForPrayer(String name) async {
    int id = name.hashCode;
    await Alarm.stop(id);
    isAlarmSet[name] = false;
    print('$name alarm cancelled');
  }
}

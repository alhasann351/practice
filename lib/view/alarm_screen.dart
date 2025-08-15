import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/prayer_time_controller.dart';

class AlarmScreen extends StatelessWidget {
  final controller = Get.put(PrayerTimeController());

  AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Time & Alarm'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.locationError.isNotEmpty) {
          return Center(
            child: Text(
              controller.locationError.value,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        if (controller.prayerTimes.value == null) {
          return const Center(child: Text('No prayer times found.'));
        }

        final times = controller.prayerTimes.value!;
        return Center(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Today\'s Prayer Times',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildPrayerTimeSwitch('Fajr', times.fajr),
              _buildPrayerTimeSwitch('Dhuhr', times.dhuhr),
              _buildPrayerTimeSwitch('Asr', times.asr),
              _buildPrayerTimeSwitch('Maghrib', times.maghrib),
              _buildPrayerTimeSwitch('Isha', times.isha),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPrayerTimeSwitch(String name, String time) {
    return Obx(
      () => Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: SwitchListTile(
          title: Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(time, style: const TextStyle(fontSize: 16)),
          value: controller.isAlarmSet[name]!,
          onChanged: (bool value) {
            controller.toggleAlarm(name, time);
          },
        ),
      ),
    );
  }
}

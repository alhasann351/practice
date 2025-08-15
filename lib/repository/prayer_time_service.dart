import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/prayer_time_model.dart';

class PrayerTimeService {
  Future<PrayerTime> getPrayerTimes(double lat, double lon) async {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    final url =
        'http://api.aladhan.com/v1/timings/$timestamp?latitude=$lat&longitude=$lon&method=2';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PrayerTime.fromJson(data['data']['timings']);
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}

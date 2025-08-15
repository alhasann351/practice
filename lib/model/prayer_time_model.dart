class PrayerTime {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTime({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime(
      fajr: json['Fajr'] ?? 'N/A',
      dhuhr: json['Dhuhr'] ?? 'N/A',
      asr: json['Asr'] ?? 'N/A',
      maghrib: json['Maghrib'] ?? 'N/A',
      isha: json['Isha'] ?? 'N/A',
    );
  }
}

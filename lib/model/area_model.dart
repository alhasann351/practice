class AreaModel {
  final String name;
  final String? country;
  final String? state;

  AreaModel({required this.name, this.country, this.state});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      name: json['name'] ?? '',
      country: json['address']?['country'],
      state: json['address']?['state'],
    );
  }
}

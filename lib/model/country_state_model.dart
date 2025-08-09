class CountryStateModel {
  bool error;
  String msg;
  List<Datum> data;

  CountryStateModel({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CountryStateModel.fromJson(Map<String, dynamic> json) {
    return CountryStateModel(
      error: json["error"] ?? false,
      msg: json["msg"] ?? "",
      data: (json["data"] as List).map((x) => Datum.fromJson(x)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "msg": msg,
      "data": data.map((x) => x.toJson()).toList(),
    };
  }
}

class Datum {
  String name;
  String iso3;
  String iso2;
  List<StateData> states;

  Datum({
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.states,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      name: json["name"] ?? "",
      iso3: json["iso3"] ?? "",
      iso2: json["iso2"] ?? "",
      states: (json["states"] as List)
          .map((x) => StateData.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "iso3": iso3,
      "iso2": iso2,
      "states": states.map((x) => x.toJson()).toList(),
    };
  }
}

class StateData {
  String name;
  String? stateCode;

  StateData({required this.name, required this.stateCode});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(name: json["name"] ?? "", stateCode: json["state_code"]);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "state_code": stateCode};
  }
}

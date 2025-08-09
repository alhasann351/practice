/*import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  final String username = "alhasann200";

  var selectedCountryId = Rxn<int>();
  var selectedCountryCode = RxnString();
  var selectedStateId = Rxn<int>();
  var selectedStateCode = RxnString();
  var selectedCityId = Rxn<int>();
  var selectedCityAdminCode2 = RxnString();

  Future<List<Map<String, dynamic>>> searchCountries(String query) async {
    if (query.isEmpty) return [];
    final url =
        "http://api.geonames.org/searchJSON?name_startsWith=$query&featureClass=A&featureCode=PCLI&maxRows=10&username=$username";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data["geonames"]);
  }

  Future<List<Map<String, dynamic>>> getStates(int countryId) async {
    final url =
        "http://api.geonames.org/childrenJSON?geonameId=$countryId&username=$username";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data["geonames"]);
  }

  Future<List<Map<String, dynamic>>> getCities(String query) async {
    if (query.isEmpty ||
        selectedCountryCode.value == null ||
        selectedStateCode.value == null)
      return [];

    final url =
        "http://api.geonames.org/searchJSON?name_startsWith=$query&featureClass=P&country=${selectedCountryCode.value}&adminCode1=${selectedStateCode.value}&maxRows=10&username=$username";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data["geonames"]);
  }

  /// নতুন - Area লিস্ট adminCode2 দিয়ে আনবে
  Future<List<Map<String, dynamic>>> getAreasByAdminCode2(String query) async {
    if (selectedCityAdminCode2.value == null ||
        selectedCountryCode.value == null)
      return [];

    final url =
        "http://api.geonames.org/searchJSON?name_startsWith=$query&featureClass=P&country=${selectedCountryCode.value}&adminCode2=${selectedCityAdminCode2.value}&maxRows=10&username=$username";
    print("Area API URL: $url");

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data["geonames"]);
  }

  Future<List<Map<String, dynamic>>> getAreasByCityId(int cityId) async {
    final url =
        "http://api.geonames.org/childrenJSON?geonameId=$cityId&username=$username";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data["geonames"] ?? []);
  }
}*/

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  final String username = "alhasann200";

  var selectedCountryId = Rxn<int>();
  var selectedCountryCode = RxnString();
  var selectedStateId = Rxn<int>();
  var selectedStateCode = RxnString();

  // Country সার্চ
  Future<List<Map<String, dynamic>>> searchCountries(String query) async {
    if (query.isEmpty) return [];
    final url =
        "http://api.geonames.org/searchJSON?name_startsWith=$query&featureClass=A&featureCode=PCLI&maxRows=10&username=$username";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data["geonames"] ?? []);
  }

  // State আনো
  Future<List<Map<String, dynamic>>> getStates(int countryId) async {
    final url =
        "http://api.geonames.org/childrenJSON?geonameId=$countryId&username=$username";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data["geonames"] ?? []);
  }

  // City + Area একসাথে আনবে
  Future<List<Map<String, dynamic>>> getCityAreaSuggestions(
    String query,
  ) async {
    if (query.isEmpty ||
        selectedCountryCode.value == null ||
        selectedStateCode.value == null)
      return [];

    List<Map<String, dynamic>> combined = [];

    // City গুলো আনো (featureClass=P)
    final cityUrl =
        "http://api.geonames.org/searchJSON?name_startsWith=$query&featureClass=P&country=${selectedCountryCode.value}&adminCode1=${selectedStateCode.value}&maxRows=10&username=$username";
    final cityRes = await http.get(Uri.parse(cityUrl));
    final cityData = json.decode(cityRes.body);
    List<Map<String, dynamic>> cities = List<Map<String, dynamic>>.from(
      cityData["geonames"] ?? [],
    );

    combined.addAll(
      cities.map(
        (c) => {"name": c["name"], "type": "City", "geonameId": c["geonameId"]},
      ),
    );

    // State এর নিচে থাকা Area গুলো আনো
    if (selectedStateId.value != null) {
      final areaUrl =
          "http://api.geonames.org/childrenJSON?geonameId=${selectedStateId.value}&username=$username";
      final areaRes = await http.get(Uri.parse(areaUrl));
      final areaData = json.decode(areaRes.body);
      List<Map<String, dynamic>> areas = List<Map<String, dynamic>>.from(
        areaData["geonames"] ?? [],
      );

      combined.addAll(
        areas.map(
          (a) => {
            "name": a["name"],
            "type": "Area",
            "geonameId": a["geonameId"],
          },
        ),
      );
    }

    // Query অনুযায়ী filter করো আবার combined
    combined = combined
        .where(
          (item) => item["name"].toString().toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();

    return combined;
  }
}

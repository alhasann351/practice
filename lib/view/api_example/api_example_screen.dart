/*import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../view_model/controller/api_example_controller/location_controller.dart';

class ApiExampleScreen extends StatelessWidget {
  final locationController = Get.put(LocationController());

  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();

  ApiExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location Selector")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Country
            TypeAheadField<Map<String, dynamic>>(
              controller: countryController,
              suggestionsCallback: (pattern) =>
                  locationController.searchCountries(pattern),
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion["name"]));
              },
              onSelected: (suggestion) {
                countryController.text = suggestion["name"];
                locationController.selectedCountryId.value =
                    suggestion["geonameId"];
                locationController.selectedCountryCode.value =
                    suggestion["countryCode"];
                stateController.clear();
                cityController.clear();
                areaController.clear();
              },
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: countryController,
                  focusNode: focusNode,
                  decoration: InputDecoration(labelText: "Country"),
                );
              },
            ),
            SizedBox(height: 16),

            // State
            Obx(() {
              if (locationController.selectedCountryId.value == null) {
                return Text("Select a country first");
              }
              return TypeAheadField<Map<String, dynamic>>(
                controller: stateController,
                suggestionsCallback: (pattern) => locationController.getStates(
                  locationController.selectedCountryId.value!,
                ),
                itemBuilder: (context, suggestion) {
                  return ListTile(title: Text(suggestion["name"]));
                },
                onSelected: (suggestion) {
                  stateController.text = suggestion["name"];
                  locationController.selectedStateId.value =
                      suggestion["geonameId"];
                  locationController.selectedStateCode.value =
                      suggestion["adminCode1"];
                  cityController.clear();
                  areaController.clear();
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: stateController,
                    focusNode: focusNode,
                    decoration: InputDecoration(labelText: "State/Division"),
                  );
                },
              );
            }),
            SizedBox(height: 16),

            // City
            Obx(() {
              if (locationController.selectedStateId.value == null) {
                return Text("Select a state first");
              }
              return TypeAheadField<Map<String, dynamic>>(
                controller: cityController,
                suggestionsCallback: (pattern) =>
                    locationController.getCities(pattern),
                itemBuilder: (context, suggestion) {
                  return ListTile(title: Text(suggestion["name"]));
                },
                // City সিলেক্ট করার সময়
                onSelected: (suggestion) {
                  cityController.text = suggestion["name"];
                  locationController.selectedCityId.value =
                      suggestion["geonameId"];
                  areaController.clear();
                },

                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: cityController,
                    focusNode: focusNode,
                    decoration: InputDecoration(labelText: "City"),
                  );
                },
              );
            }),
            SizedBox(height: 16),

            // Area
            // Area input field - visible হবে City সিলেক্ট করার পর
            Obx(() {
              if (locationController.selectedCityId.value == null) {
                return Text("Select a city first");
              }
              return TypeAheadField<Map<String, dynamic>>(
                controller: areaController,
                suggestionsCallback: (pattern) => locationController
                    .getAreasByCityId(locationController.selectedCityId.value!),
                itemBuilder: (context, suggestion) {
                  return ListTile(title: Text(suggestion["name"]));
                },
                onSelected: (suggestion) {
                  areaController.text = suggestion["name"];
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(labelText: "Area"),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../view_model/controller/api_example_controller/location_controller.dart';

class ApiExampleScreen extends StatelessWidget {
  final locationController = Get.put(LocationController());

  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityAreaController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  ApiExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Selector")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Country
            TypeAheadField<Map<String, dynamic>>(
              controller: countryController,
              hideWithKeyboard: false,
              suggestionsCallback: (pattern) =>
                  locationController.searchCountries(pattern),
              decorationBuilder: (context, child) => Material(
                type: MaterialType.card,
                elevation: 4,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: child,
              ),
              itemBuilder: (context, suggestion) =>
                  ListTile(title: Text(suggestion["name"])),
              onSelected: (suggestion) {
                countryController.text = suggestion["name"];
                locationController.selectedCountryId.value =
                    suggestion["geonameId"];
                locationController.selectedCountryCode.value =
                    suggestion["countryCode"];
                stateController.clear();
                cityAreaController.clear();
                locationController.selectedStateId.value = null;
                locationController.selectedStateCode.value = null;
              },
              builder: (context, controller, focusNode) => TextField(
                controller: countryController,
                focusNode: focusNode,
                decoration: const InputDecoration(labelText: "Country"),
              ),
            ),
            const SizedBox(height: 16),

            // State
            Obx(() {
              if (locationController.selectedCountryId.value == null) {
                return const Text("Select a country first");
              }
              return TypeAheadField<Map<String, dynamic>>(
                controller: stateController,
                hideWithKeyboard: false,
                suggestionsCallback: (pattern) => locationController.getStates(
                  locationController.selectedCountryId.value!,
                ),
                itemBuilder: (context, suggestion) =>
                    ListTile(title: Text(suggestion["name"])),
                onSelected: (suggestion) {
                  stateController.text = suggestion["name"];
                  locationController.selectedStateId.value =
                      suggestion["geonameId"];
                  locationController.selectedStateCode.value =
                      suggestion["adminCode1"];
                  cityAreaController.clear();
                },
                builder: (context, controller, focusNode) => TextField(
                  controller: stateController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: "State/Division",
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            // City / Area (combined)
            Obx(() {
              if (locationController.selectedStateId.value == null) {
                return const Text("Select a state first");
              }
              return TypeAheadField<Map<String, dynamic>>(
                controller: cityAreaController,
                hideWithKeyboard: false,
                suggestionsCallback: (pattern) =>
                    locationController.getCityAreaSuggestions(pattern),
                itemBuilder: (context, suggestion) {
                  return Text(suggestion["name"]);
                },
                onSelected: (suggestion) {
                  cityAreaController.text = suggestion["name"];
                },
                builder: (context, controller, focusNode) => TextField(
                  controller: cityAreaController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(labelText: "City / Area"),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

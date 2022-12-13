// To parse this JSON data, do
//
//     final locationResponse = locationResponseFromJson(jsonString);

import 'dart:convert';

LocationResponse locationResponseFromJson(String str, int code) =>
    LocationResponse.fromJson(json.decode(str), code);

class LocationResponse {
  LocationResponse({
    required this.results,
    required this.generationtimeMs,
    required this.statusCode,
  });

  List<Location> results;
  double generationtimeMs;
  int statusCode;

  factory LocationResponse.fromJson(Map<String, dynamic> json, int code) =>
      LocationResponse(
          results: json["results"] == null
              ? []
              : List<Location>.from(
                  json["results"].map((x) => Location.fromJson(x))),
          generationtimeMs: json["generationtime_ms"].toDouble(),
          statusCode: code);
}

class Location {
  Location({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.elevation,
    this.featureCode,
    this.countryCode,
    this.admin1Id,
    this.admin2Id,
    this.admin3Id,
    this.timezone,
    this.population,
    this.postcodes,
    this.countryId,
    this.country,
    this.admin1,
    this.admin2,
    this.admin3,
  });

  String? id;
  String? name;
  String? latitude;
  String? longitude;
  String? elevation;
  String? featureCode;
  String? countryCode;
  String? admin1Id;
  String? admin2Id;
  String? admin3Id;
  String? timezone;
  String? population;
  List<String>? postcodes;
  String? countryId;
  String? country;
  String? admin1;
  String? admin2;
  String? admin3;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"].toString(),
        name: json["name"].toString(),
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        elevation: json["elevation"].toString(),
        featureCode: json["feature_code"].toString(),
        countryCode: json["country_code"].toString(),
        admin1Id: json["admin1_id"].toString(),
        admin2Id: json["admin2_id"].toString(),
        admin3Id: json["admin3_id"].toString(),
        timezone: json["timezone"].toString(),
        population: json["population"].toString(),
        postcodes: json["postcodes"]==null?[]:List<String>.from(json["postcodes"].map((x) => x)),
        countryId: json["country_id"].toString(),
        country: json["country"].toString(),
        admin1: json["admin1"].toString(),
        admin2: json["admin2"].toString(),
        admin3: json["admin3"].toString(),
      );
}

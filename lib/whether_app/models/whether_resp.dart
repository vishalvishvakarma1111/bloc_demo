// To parse this JSON data, do
//
//     final whetherResponse = whetherResponseFromJson(jsonString);

import 'dart:convert';

WhetherResponse whetherResponseFromJson(String str, bool status, String msg) =>
    WhetherResponse.fromJson(json.decode(str), status, msg);

class WhetherResponse {
  WhetherResponse({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentWeather,
    required this.message,
    required this.status,
  });

  String? latitude;
  String? longitude;
  String? generationtimeMs;
  String? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  String? elevation;
  CurrentWeather? currentWeather;
  String message;
  bool status;

  factory WhetherResponse.fromJson(
          Map<String, dynamic> json, bool status, String msg) =>
      WhetherResponse(
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        generationtimeMs: json["generationtime_ms"].toString(),
        utcOffsetSeconds: json["utc_offset_seconds"].toString(),
        timezone: json["timezone"].toString(),
        timezoneAbbreviation: json["timezone_abbreviation"].toString(),
        elevation: json["elevation"].toString(),
        message: msg,
        status: status,
        currentWeather: CurrentWeather.fromJson(
          json["current_weather"],
        ),
      );
}

class CurrentWeather {
  CurrentWeather({
    this.temperature,
    this.windspeed,
    this.winddirection,
    this.weathercode,
    this.time,
  });

  String? temperature;
  String? windspeed;
  String? winddirection;
  String? weathercode;
  String? time;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        temperature: json["temperature"].toString(),
        windspeed: json["windspeed"].toString(),
        winddirection: json["winddirection"].toString(),
        weathercode: json["weathercode"].toString(),
        time: json["time"].toString(),
      );
}

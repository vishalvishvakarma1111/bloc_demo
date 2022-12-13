import 'dart:developer';

import 'package:psspl_bloc_demo/whether_app/models/location.dart';
import 'package:http/http.dart' as http;
import '../models/whether_resp.dart';

class ApiClient {
  Future<LocationResponse> locationSearch(String query) async {
    try {
      final locationRequest = Uri.https(
        'geocoding-api.open-meteo.com',
        '/v1/search',
        {'name': query, 'count': '1'},
      );

      final locationResponse = await http.Client().get(locationRequest);
      log("---- getWhetherDetails ---",error: locationResponse.body.toString());
      if (locationResponse.statusCode == 200) {
        return locationResponseFromJson(locationResponse.body.toString(), 200);
      } else {
        return LocationResponse(
            generationtimeMs: 0, results: [], statusCode: 500);
      }
    } catch (e) {
      print(e);
      return LocationResponse(
          generationtimeMs: 0, results: [], statusCode: 500);
    }
  }

  Future<WhetherResponse> getWhetherDetails(String lat, String long) async {
    try {
      final locationRequest = Uri.https('api.open-meteo.com', 'v1/forecast',
          {'latitude': lat, 'longitude': long, 'current_weather': 'true'});
      final response = await http.Client().get(locationRequest);

      log("---- getWhetherDetails ---",error: response.body.toString());
      if (response.statusCode == 200) {
        return whetherResponseFromJson(
            response.body.toString(), true, "success");
      } else {
        return WhetherResponse(
            status: false, message: response.body.toString());
      }
    } catch (e) {
      print(e);
      return WhetherResponse(status: false, message: e.toString());
    }
  }
}

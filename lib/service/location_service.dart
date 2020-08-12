import 'dart:convert';

import 'package:parking_app/domain/location.dart';
import 'package:requests/requests.dart';

class LocationService {
  String baseUrl = 'http://192.168.0.101:8080/api/v1/location/';
  LocationService();

  Future<List<Location>> getLocations() async {
    var response = await Requests.get(baseUrl + "all");
    return (json.decode(response.content()) as List)
        .map((e) => Location.fromJson(e) as Location)
        .toList();
  }
}

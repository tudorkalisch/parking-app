import 'dart:convert';
import 'dart:core';

import 'package:parking_app/domain/booking.dart';
import 'package:parking_app/service/preference_settings.dart';
import 'package:requests/requests.dart';

class BookingService {
  String baseUrl = 'http://192.168.0.101:8080/api/v1/booking/';
  BookingService();

  Future<List<Booking>> getBookings() async {
    String userId = await SharedPrefs.getUserId();
    var response =
        await Requests.get(baseUrl + "all", headers: {'user_id': userId});

    return (json.decode(response.content()) as List)
        .map((e) => Booking.fromJson(e) as Booking)
        .toList();
  }

  Future<void> addBooking(Booking booking) async {
    String userId = await SharedPrefs.getUserId();
    var r = await Requests.post(baseUrl + 'add',
        headers: {'user_id': userId},
        body: {
          'startTime': booking.startTime.millisecondsSinceEpoch,
          'endTime': booking.endTime.millisecondsSinceEpoch,
          'location': {'id': booking.location.id},
        },
        bodyEncoding: RequestBodyEncoding.JSON);

    r.raiseForStatus();
  }
}

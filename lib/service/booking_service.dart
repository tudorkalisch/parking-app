import 'dart:convert';
import 'dart:core';

import 'package:parking_app/domain/booking.dart';
import 'package:requests/requests.dart';

class BookingService {
  String baseUrl = 'http://192.168.0.149:8080/api/v1/booking/';
  BookingService();

  Future<List<Booking>> getBookings() async {
    var response = await Requests.get(baseUrl + "all");
    return (json.decode(response.content()) as List)
        .map((e) => Booking.fromJson(e) as Booking)
        .toList();
  }

  Future<void> addBooking(Booking booking) async {
    var r = await Requests.post(baseUrl + 'add',
        body: {
          'location': booking.location,
          'startTime': booking.startTime.millisecondsSinceEpoch,
          'endTime': booking.endTime.millisecondsSinceEpoch,
        },
        bodyEncoding: RequestBodyEncoding.JSON);

    r.raiseForStatus();
  }
}

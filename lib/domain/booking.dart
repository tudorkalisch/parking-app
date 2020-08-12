import 'dart:convert';
import 'dart:typed_data';

import 'location.dart';

class Booking {
  String id;
  Location location;
  DateTime startTime;
  DateTime endTime;
  Uint8List qrCode;

  Booking(this.id, this.location, this.startTime, this.endTime, this.qrCode);

  Booking.empty() {
    this.location = Location.empty();
  }

  static fromJson(e) {
    Booking b = Booking.empty();
    b.id = e['id'];
    b.location = Location.fromJson(e['location']);
    b.startTime = DateTime.fromMillisecondsSinceEpoch(e['startTime']);
    b.endTime = DateTime.fromMillisecondsSinceEpoch(e['endTime']);
    b.qrCode = base64.decode(e['qr']);
    return b;
  }
}

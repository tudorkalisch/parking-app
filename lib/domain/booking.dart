class Booking {
  String id;
  String location;
  DateTime startTime;
  DateTime endTime;

  Booking(this.id, this.location, this.startTime, this.endTime);

  Booking.empty();

  static fromJson(e) {
    Booking b = Booking.empty();
    b.id = e['id'];
    b.location = e['location'];
    b.startTime = DateTime.fromMillisecondsSinceEpoch(e['startTime']);
    b.endTime = DateTime.fromMillisecondsSinceEpoch(e['endTime']);
    return b;
  }
}

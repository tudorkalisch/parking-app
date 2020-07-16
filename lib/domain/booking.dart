class Booking {
  String id;
  String location;
  DateTime startTime;
  DateTime endTime;

  Booking(this.id, this.location, this.startTime, this.endTime);

  Booking.empty() {
    this.location = "Location";
  }
}

class AvailableTime {
  String name;
  DateTime time;

  AvailableTime(this.name, this.time);

  String getReadableTime() {
    return time.hour.toString() + ":" + time.minute.toString();  }
}
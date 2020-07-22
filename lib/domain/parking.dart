class Parking {
  String id;
  String name;
  String location;
  double rating;

  Parking(this.id, this.name, this.location, this.rating);

  Parking.empty() {
    id = "12321341";
    name = "Name";
    location = "Location";
    rating = 5.5;
  }
}

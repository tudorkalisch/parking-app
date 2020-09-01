import 'dart:convert';

import 'dart:typed_data';

class Location {
  String id;
  String name;
  Uint8List thumbnail;
  double price;
  double rating;
  double longitude;
  double latitude;

  Location(this.id, this.name, this.thumbnail, this.price, this.rating,
      this.longitude, this.latitude);

  Location.empty();

  static fromJson(e) {
    Location l = Location.empty();
    l.id = e['id'];
    l.name = e['name'];
    l.thumbnail = base64.decode(e['thumbnail']);
    l.price = e['price'];
    l.rating = e['rating'];
    l.longitude = e['longitude'];
    l.latitude = e['latitude'];

    return l;
  }
}

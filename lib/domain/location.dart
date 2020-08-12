import 'dart:convert';

import 'dart:typed_data';

class Location {
  String id;
  String name;
  Uint8List thumbnail;
  double price;
  double rating;

  Location(this.id, this.name, this.thumbnail, this.price);

  Location.empty();

  static fromJson(e) {
    Location l = Location.empty();
    l.id = e['id'];
    l.name = e['name'];
    l.thumbnail = base64.decode(e['thumbnail']);
    l.price = e['price'];
    l.rating = e['rating'];
    return l;
  }
}

import 'package:flutter/material.dart';
import 'package:parking_app/domain/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final Function goToSchedule;

  LocationCard(this.location, this.goToSchedule);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () {
              goToSchedule(location, context);
            },
            child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 265,
                    width: 400,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          alignment: Alignment.topLeft,
                          child: Text(
                            location.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 16.0),
                          ),
                        ),
                        Image.memory(
                          location.thumbnail,
                          fit: BoxFit.fill,
                          width: 400,
                          height: 200,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                          width: 400,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Text(
                                  formatPrice(location.price),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 16.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Text(
                                  formatRating(location.rating),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 16.0),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )))));
  }

  String formatPrice(double price) {
    return "Price: " + price.toString() + "\$";
  }

  String formatRating(double rating) {
    return "Rating " + rating.toString() + "\\5.0";
  }
}

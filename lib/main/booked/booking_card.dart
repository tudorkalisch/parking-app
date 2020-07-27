import 'package:flutter/material.dart';
import 'package:parking_app/domain/booking.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard(this.booking);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        booking.location,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                      )),
                    ],
                  )),
            ],
          ),
        ));
  }
}

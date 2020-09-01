import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:parking_app/domain/booking.dart';
import 'package:parking_app/domain/location.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard(this.booking);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(12, 9, 0, 0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      "Location: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      booking.location.name,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Flex(
                      mainAxisSize: MainAxisSize.max,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          formatDate(booking.startTime),
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Flex(
                      mainAxisSize: MainAxisSize.min,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          formatMinutesAndHours(booking.startTime),
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 30),
                        ),
                        Text(
                          " to ",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          formatMinutesAndHours(booking.startTime),
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 30),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: IconButton(
                      color: Colors.blueAccent,
                      iconSize: 30,
                      icon: Icon(Icons.blur_circular),
                      onPressed: () {
                        showQRCode(booking.qrCode, context);
                      },
                    ),
                  )
                ])),
            Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 8),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blueAccent)),
                    color: Colors.blue,
                    onPressed: () => openMapsAppToLocation(booking.location),
                    child: Text(
                      "Take me there",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )))
          ],
        ));
  }

  void openMapsAppToLocation(Location location) async {
    final availableMaps = await MapLauncher.installedMaps
        .catchError((error) => {print(error.toString())});
    print(
        availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showDirections(
      destination: Coords(location.latitude, location.longitude),
    );
  }

  String formatMinutesAndHours(DateTime dateTime) {
    String hour = dateTime.hour.toString();
    String minutes = dateTime.minute.toString();
    if (dateTime.minute < 10) {
      minutes = "0" + minutes;
    }

    if (dateTime.hour < 10) {
      hour = "0" + hour;
    }

    return hour + ":" + minutes;
  }

  String formatDate(DateTime dateTime) {
    String day = dateTime.day.toString();

    if (dateTime.day < 10) {
      day = "0" + day;
    }

    String month = formatMonth(dateTime.month);

    return day + " " + month;
  }

  String formatMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return "Jan";
  }

  void showQRCode(Uint8List qr, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return createQRCodeDialog(qr, context).build(context);
        },
        barrierDismissible: true);
  }

  AlertDialog createQRCodeDialog(Uint8List qr, BuildContext context) {
    return AlertDialog(
        title: Text(
          "Booking QR Code",
          style: TextStyle(color: Colors.blue),
        ),
        content: Image.memory(
          qr,
          fit: BoxFit.fill,
          width: 500,
          height: 500,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            textColor: Colors.blue,
            onPressed: () => {Navigator.pop(context)},
          )
        ],
        elevation: 24.0);
  }
}

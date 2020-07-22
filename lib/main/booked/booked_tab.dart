import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/service/booking_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/domain/booking.dart';

// ignore: must_be_immutable
class BookedTab extends StatefulWidget {
  BookingService bookingService;

  BookedTab() {
    this.bookingService = locator<BookingService>();
  }

  @override
  _BookedTabState createState() => _BookedTabState(bookingService);
}

class _BookedTabState extends State<BookedTab> with WidgetsBindingObserver {
  BookingService bookingsService;
  List<Booking> _bookings;

  _BookedTabState(this.bookingsService);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _bookings = bookingsService.getBookings();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _bookings = bookingsService.getBookings();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _bookings
          .map((element) => Card(
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
                              element.location,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 16.0),
                            )),
                          ],
                        )),
                  ],
                ),
              )))
          .toList(),
    );
  }
}

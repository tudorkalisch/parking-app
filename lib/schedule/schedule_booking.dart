import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/domain/location.dart';
import 'package:parking_app/service/booking_service.dart';
import 'package:parking_app/domain/booking.dart';
import 'package:parking_app/schedule/calendar/calendar_view.dart';
import 'package:parking_app/schedule/payment/payment_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'available_time/available_time_view.dart';

class ScheduleView extends StatefulWidget {
  static const routeName = '/schedule';

  final Location location;
  ScheduleView(this.location);

  @override
  State<StatefulWidget> createState() {
    return ScheduleState(location);
  }
}

class ScheduleState extends State<ScheduleView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  BookingService bookingService;
  Booking currentBooking = Booking.empty();
  Location currentLocation;

  ScheduleState(this.currentLocation) {
    this.currentBooking.location = currentLocation;
  }

  @override
  void initState() {
    super.initState();
    this.tabController = new TabController(vsync: this, length: 3);
    this.bookingService = locator<BookingService>();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void navigateToNext() {
    tabController.index = tabController.index + 1;
  }

  void onDaySelected(DateTime day, List events) {
    setState(() {
      this.currentBooking.startTime = day;
      this.currentBooking.endTime = day;
    });
  }

  void onStartTimeSelected(TimeOfDay startTime) {
    setState(() {
      this.currentBooking.startTime = new DateTime(
          currentBooking.startTime.year,
          currentBooking.startTime.month,
          currentBooking.startTime.day,
          startTime.hour,
          startTime.minute);
    });
  }

  void onEndTimeSelected(TimeOfDay endTime) {
    setState(() {
      this.currentBooking.endTime = new DateTime(
          currentBooking.endTime.year,
          currentBooking.endTime.month,
          currentBooking.endTime.day,
          endTime.hour,
          endTime.minute);
    });
  }

  void onPaymentComplete() {
    bookingService
        .addBooking(currentBooking)
        .then(onAddBookingSuccess)
        .catchError(onAddBookingError);
  }

  void onAddBookingError(dynamic value) {}

  void onAddBookingSuccess(dynamic value) async {
    print("Booking succesful");
    goToMain();
  }

  void goToMain() {
    Navigator.of(context).popUntil(ModalRoute.withName('/main'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("New booking"),
            bottom: TabBar(
              controller: tabController,
              labelColor: Colors.white,
              tabs: [
                Tab(text: "Calendar"),
                Tab(text: "Time"),
                Tab(text: "Payment")
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              CalendarView(this.onDaySelected),
              AvailableTimeWidget(this.onStartTimeSelected,
                  this.onEndTimeSelected, this.currentBooking),
              PaymentView(
                  this.onPaymentComplete, currentLocation, currentBooking),
            ],
          ),
          bottomNavigationBar: new BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: Colors.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      navigateToNext();
                    },
                    disabledTextColor: Colors.grey,
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

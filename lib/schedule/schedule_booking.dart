import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/service/booking_service.dart';
import 'package:parking_app/domain/booking.dart';
import 'package:parking_app/domain/available_time.dart';
import 'package:parking_app/schedule/calendar/calendar_view.dart';
import 'package:parking_app/schedule/payment/payment_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'available_time/available_time_view.dart';

class ScheduleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScheduleState();
  }
}

class ScheduleState extends State<ScheduleView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  BookingService bookingService;
  Booking currentBooking;

  @override
  void initState() {
    super.initState();
    this.tabController = new TabController(vsync: this, length: 3);
    this.bookingService = locator<BookingService>();
    this.currentBooking = Booking.empty();
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
    print(day.toString() + " " + events.toString());

    this.currentBooking.startTime = day;
    navigateToNext();
  }

  void onTimeSelected(DateTime time) {
    print(time.toString());

    this.currentBooking.startTime.add(Duration(hours: time.hour));
    navigateToNext();
  }

  void onPaymentComplete() {
    print("Payment complete");

    bookingService.addBooking(currentBooking);
    Navigator.of(context).popUntil(ModalRoute.withName("/main"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
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
              AvailableTimeWidget(this.onTimeSelected, [
                AvailableTime("Parking1", DateTime.now()),
                AvailableTime(
                    "Parking2", DateTime.now().add(Duration(hours: 1))),
                AvailableTime(
                    "Parking2", DateTime.now().add(Duration(hours: 2))),
                AvailableTime(
                    "Parking2", DateTime.now().add(Duration(hours: 3))),
                AvailableTime(
                    "Parking2", DateTime.now().add(Duration(hours: 4))),
                AvailableTime(
                    "Parking2", DateTime.now().add(Duration(hours: 5))),
              ]),
              PaymentView(this.onPaymentComplete),
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

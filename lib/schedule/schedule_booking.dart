import 'package:berting_app/domain/available_time.dart';
import 'package:berting_app/schedule/calendar/calendar_view.dart';
import 'package:berting_app/schedule/payment/payment_view.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 3);
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
    navigateToNext();
  }

  void onTimeSelected(DateTime time) {
    print(time.toString());
    navigateToNext();
  }

  void onPaymentComplete() {
    print("Payment complete");
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
                AvailableTime("Parking2", DateTime.now()),
                AvailableTime("Parking3", DateTime.now()),
                AvailableTime("Parking4", DateTime.now()),
                AvailableTime("Parking5", DateTime.now()),
                AvailableTime("Parking6", DateTime.now())
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

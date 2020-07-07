import 'dart:developer';
import 'package:flutter/material.dart';
import 'available_tab.dart';
import 'package:berting_app/domain/booking.dart';
import 'package:berting_app/schedule/schedule_booking.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.lightBlueAccent,
          primarySwatch: Colors.lightBlue,
          hintColor: Colors.white,
          brightness: Brightness.light),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                labelColor: Colors.white,
                tabs: [
                  Tab(text: "Available"),
                  Tab(text: "Booked"),
                  Tab(text: "Upcoming")
                ],
              ),
              leading: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "https://scontent.fomr1-1.fna.fbcdn.net/v/t1.0-9/92373732_2999831916739864_2570881927766605824_o.jpg?_nc_cat=110&_nc_sid=09cbfe&_nc_ohc=GwQkWbCgm7gAX_-s6QH&_nc_ht=scontent.fomr1-1.fna&oh=dc754d2a41ea5c0469d7494d254830ed&oe=5F090E92"))),
              title: Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tudor Kalisch",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Online",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                alignment: Alignment.topLeft,
              )),
          extendBody: true,
          bottomNavigationBar: new BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.lightBlue,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              scheduleBooking(context);
            },
          ),
          body: TabBarView(
            children: [
              AvailableTab([Booking("Parking Lake Birmingham", 3.2)]),
              Text("Hello"),
              Text("Upcoming")
            ],
          ),
        ),
      ),
    );
  }

  void scheduleBooking(BuildContext context) {
    log("message");
    Navigator.pushNamed(context, "/schedule");
  }
}

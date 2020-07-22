import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parking_app/main/views/main_app_bar.dart';
import 'package:parking_app/main/views/main_bottom_bar.dart';
import 'available/availbable_tab.dart';
import 'booked/booked_tab.dart';

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
        length: 2,
        child: Scaffold(
          appBar: MainAppBar().build(context),
          extendBody: true,
          bottomNavigationBar: MainBottomBar().build(context),
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
            children: [AvailableTab(), BookedTab()],
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

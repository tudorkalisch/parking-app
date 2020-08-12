import 'package:flutter/material.dart';
import 'package:parking_app/main/views/main_app_bar.dart';
import 'package:parking_app/main/views/main_bottom_bar.dart';
import 'package:parking_app/schedule/schedule_booking.dart';
import 'available/availbable_tab.dart';
import 'booked/booked_tab.dart';

class MainView extends StatelessWidget {
  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: MainAppBar().build(context),
          extendBody: true,
          bottomNavigationBar: MainBottomBar().build(context),
          body: TabBarView(
            children: [AvailableTab(context, scheduleBooking()), BookedTab()],
          ),
        ),
      ),
    );
  }

  Function scheduleBooking() {
    return (location, context) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ScheduleView(location)));
  }
}

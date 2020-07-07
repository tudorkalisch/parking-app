import 'package:berting_app/schedule/schedule_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:berting_app/login/login_view.dart';

import 'main/main_view.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        '/main': (BuildContext context) => MainView(),
        '/schedule': (BuildContext context) => ScheduleView(),
        '/login': (BuildContext context) => LoginView(),
      },
      home: LoginView(),
    );
  }
}

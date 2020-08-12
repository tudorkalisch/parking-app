import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking_app/login/login_view.dart';

import 'di/service_locator.dart';
import 'main/main_view.dart';

void main() => start();

void start() {
  setupLocator();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      theme: ThemeData(
          accentColor: Colors.lightBlueAccent,
          primarySwatch: Colors.lightBlue,
          hintColor: Colors.white,
          brightness: Brightness.light),
      routes: {
        MainView.routeName: (BuildContext context) => MainView(),
        LoginView.routeName: (BuildContext context) => LoginView(),
      },
      home: LoginView(),
    );
  }
}

import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        bottom: TabBar(
          labelColor: Colors.white,
          tabs: [Tab(text: "Available"), Tab(text: "Booked")],
        ),
        leading: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    "https://scontent.fomr1-1.fna.fbcdn.net/v/t1.0-9/92373732_2999831916739864_2570881927766605824_o.jpg?_nc_cat=110&_nc_sid=09cbfe&_nc_ohc=bowsgeNftZYAX_zQrx8&_nc_ht=scontent.fomr1-1.fna&oh=b89e6c819b7bad20782f281ae27f9bbd&oe=5F349012"))),
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
        ));
  }
}

import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final Function logout;

  MainAppBar(this.logout);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        bottom: TabBar(
          labelColor: Colors.white,
          tabs: [
            Tab(text: "Available"),
            Tab(text: "Booked"),
            Tab(text: "Past bookings")
          ],
        ),
        leading: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    "https://scontent.fomr1-1.fna.fbcdn.net/v/t1.0-9/92373732_2999831916739864_2570881927766605824_o.jpg?_nc_cat=110&_nc_sid=09cbfe&_nc_ohc=_dVvl0u4gdgAX_XdinC&_nc_ht=scontent.fomr1-1.fna&oh=897488d410a30a465d53900d36f92105&oe=5F5C1D12"))),
        title: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
              ),
              FlatButton(
                onPressed: () {
                  this.logout(context);
                },
                textColor: Colors.white,
                child: Text("Logout"),
              )
            ]));
  }
}

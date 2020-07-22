import 'package:flutter/material.dart';

class MainBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new BottomAppBar(
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
    );
  }
}

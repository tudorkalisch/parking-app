import 'package:parking_app/domain/available_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableList extends StatelessWidget {
  final List<AvailableTime> times;
  final Function onTimeSelected;

  AvailableList(this.times, this.onTimeSelected);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: times
          .map((element) => Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                            onTap: () {
                              onTimeSelected(element.time);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  element.name,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 16.0),
                                )),
                                Expanded(
                                    child: Text(
                                  element.getReadableTime(),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 16.0),
                                ))
                              ],
                            ))),
                  ],
                ),
              )))
          .toList(),
    );
  }
}

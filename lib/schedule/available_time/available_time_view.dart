import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:parking_app/domain/booking.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

class AvailableTimeWidget extends StatefulWidget {
  final Function onStartTimeSelected;
  final Function onEndTimeSelected;
  final Booking currentBooking;

  AvailableTimeWidget(
      this.onStartTimeSelected, this.onEndTimeSelected, this.currentBooking);

  @override
  _AvailableTimeWidgetState createState() => _AvailableTimeWidgetState();
}

class _AvailableTimeWidgetState extends State<AvailableTimeWidget> {
  TimeOfDay startTime;
  TimeOfDay endTime;

  @override
  void initState() {
    super.initState();
    startTime = new TimeOfDay(
        hour: widget.currentBooking.startTime.hour,
        minute: widget.currentBooking.startTime.minute);
    endTime = new TimeOfDay(
        hour: widget.currentBooking.endTime.hour,
        minute: widget.currentBooking.endTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            padding: EdgeInsets.all(30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        startTime.format(context),
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 30),
                      ),
                      FlatButton(
                          onPressed: () async {
                            selectStartTime(
                                widget.onStartTimeSelected, context);
                          },
                          child: Text(
                            "Select start time",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        endTime.format(context),
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 30),
                      ),
                      FlatButton(
                          onPressed: () async {
                            selectEndTime(widget.onEndTimeSelected, context);
                          },
                          child: Text(
                            "Select end time",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                ]),
          )
        ]);
  }

  void selectStartTime(
      Function onStartTimeSelected, BuildContext context) async {
    TimeOfDay temp = await PlatformDatePicker.showTime(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() => {
          {startTime = temp}
        });
    onStartTimeSelected(startTime);
  }

  void selectEndTime(Function onEndTimeSelected, BuildContext context) async {
    TimeOfDay temp = await PlatformDatePicker.showTime(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() => {endTime = temp});
    onEndTimeSelected(endTime);
  }
}

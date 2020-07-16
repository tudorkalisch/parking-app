import 'package:parking_app/domain/available_time.dart';
import 'package:parking_app/schedule/available_time/available_list.dart';
import 'package:flutter/cupertino.dart';

class AvailableTimeWidget extends StatelessWidget {
  final List<AvailableTime> availableTimes;

  final Function onTimeSelected;

  AvailableTimeWidget(this.onTimeSelected, this.availableTimes);

  @override
  Widget build(BuildContext context) {
    return AvailableList(availableTimes, onTimeSelected);
  }
}

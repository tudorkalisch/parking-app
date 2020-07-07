import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final Function onDaySelected;
  CalendarView(this.onDaySelected);

  @override
  State<StatefulWidget> createState() {
    return CalendarState(onDaySelected);
  }
}

class CalendarState extends State<CalendarView> {
  var calendarController = CalendarController();
  final Function onDaySelected;
  CalendarState(this.onDaySelected);

  @override
  void initState() {
    super.initState();
    calendarController = CalendarController();
  }

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildCalendar();
  }

  Widget buildCalendar() {
    return TableCalendar(
      calendarController: calendarController,
      onDaySelected: onDaySelected,
    );
  }

}

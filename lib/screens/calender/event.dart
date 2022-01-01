import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class CalendarScreenTest extends StatefulWidget {
  const CalendarScreenTest({Key? key}) : super(key: key);

  @override
  _CalendarScreenTestState createState() => _CalendarScreenTestState();
}

class _CalendarScreenTestState extends State<CalendarScreenTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ปฏิทินกิจกรรม',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          child: SfCalendar(view: CalendarView.month,),
        ));
  }
}

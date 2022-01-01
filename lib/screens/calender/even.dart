import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/model/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../constant.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
 
 final storage = new FlutterSecureStorage();
    Future<CalendarData> getCalendar() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getCalendar'),
        headers: {
          "authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = CalendarData.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }
String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('yyyy-mm-dd');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
}

  String _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '',
      _locationText = '';

  @override
  Widget build(BuildContext context) {
    //  print(_events.length);
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
      body: buildCalendar()
    );
  }
    buildCalendar(){
    return  SfCalendar(
          view: CalendarView.month,
          viewHeaderHeight: 50,
          showDatePickerButton: true,
          initialSelectedDate: DateTime.now(),
          showNavigationArrow: true,
          dataSource: getCalendarDataSource(),
          onTap: calendarTapped,
          todayHighlightColor: Color(0xFFcc0066),
          monthViewSettings: MonthViewSettings(
            showAgenda: true,
            agendaViewHeight: 300,
            agendaItemHeight: 60,
          ),
          appointmentTimeTextFormat: 'HH:mm',
          //วันหยุด
          blackoutDates: <DateTime>[
            DateTime(2021, 11, 10),
            DateTime.parse("2021-11-11T11:40:01.000Z"),
          ],
          blackoutDatesTextStyle: TextStyle(
            color: Colors.red,
          ),
        );
    }

   calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Meeting appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.eventName!;
      _locationText = appointmentDetails.location!;
      _dateText = DateFormat("d MMMM yyyy",
              'th') //.formatInBuddhistCalendarThai(appointmentDetails.from!)
          .format(appointmentDetails.from!)
          .toString();
      _startTimeText = DateFormat('hh:mm a', 'th')
          .format(appointmentDetails.from!)
          .toString();
      _endTimeText =
          DateFormat('hh:mm a', 'th').format(appointmentDetails.to!).toString();
      if (appointmentDetails.isAllDay!) {
        _timeDetails = 'ทั้งวัน';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText')),
              content: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '$_dateText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(_timeDetails,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                    Row(
                      children: [Text('สถานที่: $_locationText')],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('ปิด'))
              ],
            );
          });
    }
  }

  MeetingDataSource getCalendarDataSource() {
    
    List<Meeting> appointments = <Meeting>[];
    appointments.add(Meeting(
      from: DateTime.parse("2021-12-27"),
      to: DateTime.parse("2021-12-30"),
      eventName: 'ประชุม',
      location: 'อาคาร B',
      background: Colors.pink,
    ));
    appointments.add(Meeting(
      from: DateTime.now().add(const Duration(hours: 4, days: -1)),
      to: DateTime.now().add(const Duration(hours: 5, days: -1)),
      eventName: 'กิจกรรมตักบาตร',
      location: 'อาคาร B',
      background: Colors.lightBlueAccent,
    ));
    appointments.add(Meeting(
      from: DateTime.now().add(const Duration(hours: 2, days: -2)),
      to: DateTime.now().add(const Duration(hours: 4, days: -2)),
      eventName: 'Performance check',
      location: 'อาคาร B',
      background: Colors.amber,
    ));

    return MeetingDataSource(appointments);
  }
}

class Meeting {
  Meeting(
      {this.eventName,
      this.location,
      this.from,
      this.to,
      this.background,
      this.isAllDay = false,
      this.id});

  String? eventName;
  String? location;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  int? id;
}



class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  String getLocation(int index) {
    return appointments![index].location;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

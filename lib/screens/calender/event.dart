
import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// import 'package:animal_welfare/model/calendar_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';


class CalendarScreenTest extends StatefulWidget {
  const CalendarScreenTest({Key? key}) : super(key: key);

  @override
  _CalendarScreenTestState createState() => _CalendarScreenTestState();
}

class _CalendarScreenTestState extends State<CalendarScreenTest> {
  final storage = new FlutterSecureStorage();
  List<Color> _colorCollection=<Color>[];

  // Future<CalendarTest> getAnimal() async {
  //   String? token = await storage.read(key: 'token');
  //   String endPoint = Constant().endPoint;
  //   var response = await http.get(Uri.parse('$endPoint/api/getAnimalInZoo'),
  //       headers: {"authorization": 'Bearer $token'});
  //   print(response.body);
  //   var jsonData = CalendarTest.fromJson(jsonDecode(response.body));
  //   print('$jsonData');
  //   return jsonData;
  // }

  DateTime _convertDateFromString(String? date) {
    return DateTime.parse(date!);
  }

  void initState() {
    _initializeEventColor();
    // _checkNetworkStatus();
    super.initState();
  }

  Future<List<Meeting>> getDataFromWeb() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var data = await http.get(Uri.parse("$endPoint/api/getCalendar"),
        headers: {"authorization": 'Bearer $token'});
    var jsonData = jsonDecode(data.body);
    print(data.body);
    print(jsonData);

    final List<Meeting> appointmentData = [];
    final Random random = new Random();
    print('before loop');
    for (var data in jsonData) {
      Meeting meetingData = Meeting(
        eventName: data['calendarName'],
        from: _convertDateFromString(data['startDate']),
        to: _convertDateFromString(data['endDate']),
        background: _colorCollection[random.nextInt(9)],
      );

      appointmentData.add(meetingData);
    }
    print('after loop');
    return appointmentData;
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

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
      body: FutureBuilder<List<Meeting>>(
        future: getDataFromWeb(),
        builder: (BuildContext context, AsyncSnapshot<List<Meeting>> snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Container(
                  child: SfCalendar(
                view: CalendarView.month,
                // initialDisplayDate: DateTime(2017, 6, 01, 9, 0, 0),
                // initialSelectedDate: DateTime.now(),
                dataSource: MeetingDataSource(snapshot.data!),
              )),
            );
          } else {
            return new Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// List<Meeting> _getDataSource() {
//   final List<Meeting> meetings = <Meeting>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   meetings.add(Meeting(
//       'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//   return meetings;
// }

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
Color getColor(int index) {
  return appointments![index].background;
}

// @override
// bool isAllDay(int index) {
//   return appointments![index].isAllDay;
// }

  // Meeting _getMeetingData(int index) {
  //   final dynamic meeting = appointments![index];
  //   late final Meeting meetingData;
  //   if (meeting is Meeting) {
  //     meetingData = meeting;
  //   }
  //
  //   return meetingData;
  // }
}

class Meeting {
  // Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  Meeting({
    this.eventName,
    this.from,
    this.to,
    this.background,
  });

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  // bool isAllDay;


}

import 'dart:convert';
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
  List<Color> _colorCollection = <Color>[];

   String _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '',
      _locationText = '';

  DateTime _convertDateFromString(String? date) {
    return DateTime.parse(date!);
  }

  void initState() {
    // _initializeEventColor();
    getDataFromWeb();
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
    // final Random random = new Random();
    print('before loop');
    for (var data in jsonData) {
      Meeting meetingData = Meeting(
        eventName: data['calendarName'],
        from: _convertDateFromString(data['startDate']),
        to: _convertDateFromString(data['endDate']),
        location: (data['location']),
        background: Colors.green,
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
                viewHeaderHeight: 50,
                //  showDatePickerButton: true,
                initialSelectedDate: DateTime.now(),
                showNavigationArrow: true,
                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  agendaViewHeight: 300,
                  agendaItemHeight: 60,
                ),
                // initialDisplayDate: DateTime(2017, 6, 01, 9, 0, 0),
                // initialSelectedDate: DateTime.now(),
                dataSource: MeetingDataSource(snapshot.data!),
                 onTap: calendarTapped,
              )),
            );
          } else {
            return 
            new Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
      _startTimeText = DateFormat('hh:mm a')
          .format(appointmentDetails.from!)
          .toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.to!).toString();
      if (appointmentDetails.isAllDay) {
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
  Color getColor(int index) {
    return appointments![index].background;
  }
    @override
  String getLocation(int index) {
    return appointments![index].location;
  }
   @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  // Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  Meeting({
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.location,
    this.isAllDay = false,
  });

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
   String? location;
   bool isAllDay;

}

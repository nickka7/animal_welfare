import 'package:syncfusion_flutter_calendar/calendar.dart';
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

  Future<AllAnimals> getAnimal() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getAnimalInZoo'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = AllAnimals.fromJson(jsonDecode(response.body));
    print('$jsonData');
    return jsonData;
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
        body: Container(
          child: SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          ),
        ));
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}
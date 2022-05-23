import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/calender/addWork.dart';
import 'package:animal_welfare/screens/calender/calendar_update.dart';
import 'package:animal_welfare/screens/calender/eventDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

class EventSlide extends StatefulWidget {
  const EventSlide({Key? key}) : super(key: key);

  @override
  State<EventSlide> createState() => _EventSlideState();
}

class _EventSlideState extends State<EventSlide> {
  @override
  void initState() {
    getDataFromWeb();
    super.initState();
  }

  DateTime _convertDateFromString(String? date) {
    return DateTime.parse(date!);
  }

  final storage = new FlutterSecureStorage();

  String endPoint = Constant().endPoint;
  final snackBar = SnackBar(content: Text('ลบข้อมูลแล้ว'));

  Future<List<Appointment>> getDataFromWeb() async {
    String? token = await storage.read(key: 'token');
    var data = await http.get(Uri.parse("$endPoint/api/getCalendar"),
        headers: {"authorization": 'Bearer $token'});
    var jsonData = jsonDecode(data.body);
    // print(data.body);
    // print(jsonData);

    final List<Appointment> appointments = <Appointment>[];

    // print('before loop');
    for (var data in jsonData) {
      Appointment meetingData = Appointment(
        id: data['calendarID'],
        subject: data['calendarName'],
        startTime: _convertDateFromString(data['startDate']),
        endTime: _convertDateFromString(data['endDate']),
        location: data['location'],
        color: Colors.green,
      );

      appointments.add(meetingData);
    }
    // print(jsonData);

    return appointments;
  }

  List<Appointment> appointments = <Appointment>[];

  Future deleteCalendar(String calendarID) async {
    print(calendarID);
    String? token = await storage.read(key: 'token');
    var response = await http.delete(
        Uri.parse('$endPoint/api/deleteMySchedule/$calendarID'),
        headers: {"authorization": 'Bearer $token'});
    var jsonResponse = await json.decode(response.body);
    print(jsonResponse['message']);
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
      body: RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (a, b, c) => EventSlide(),
            transitionDuration: Duration(milliseconds: 100),
          ),
        ),
        child: FutureBuilder<List<Appointment>>(
          future: getDataFromWeb(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Appointment>> snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SfCalendar(
                        initialSelectedDate: DateTime.now(),
                        dataSource: _DataSource(snapshot.data!),
                        view: CalendarView.month,
                        viewHeaderHeight: 50,
                        showNavigationArrow: true,
                        monthViewSettings:
                            MonthViewSettings(numberOfWeeksInView: 4),
                        onTap: calendarTapped,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                            // color: Colors.black12,
                            child: ListView.separated(
                          padding: const EdgeInsets.all(2),
                          itemCount: appointments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  height: 60,
                                  color: appointments[index].color,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EventDetail(
                                                  subject: appointments[index]
                                                      .subject,
                                                  end: appointments[index]
                                                      .endTime,
                                                  location: appointments[index]
                                                      .location,
                                                  start: appointments[index]
                                                      .startTime,
                                                )),
                                      );
                                    },
                                    child: ListTile(
                                      leading: Column(
                                        children: <Widget>[
                                          Text(
                                            appointments[index].isAllDay
                                                ? ''
                                                : '${DateFormat('hh:mm a').format(appointments[index].startTime)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                height: 1.7),
                                          ),
                                          Text(
                                            appointments[index].isAllDay
                                                ? 'All day'
                                                : '',
                                            style: TextStyle(
                                                height: 0.5,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            appointments[index].isAllDay
                                                ? ''
                                                : '${DateFormat('hh:mm a').format(appointments[index].endTime)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                          child: Text(
                                              '${appointments[index].location}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ))),
                                      title: Container(
                                          child: Text(
                                              '${appointments[index].subject}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white))),
                                    ),
                                  )),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'แก้ไข',
                                  color: Colors.green,
                                  icon: Icons.build_rounded,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CalendarUpdate(
                                                id: appointments[index].id,
                                                subject:
                                                    '${appointments[index].subject}',
                                                location:
                                                    '${appointments[index].location}',
                                                start: appointments[index]
                                                    .startTime,
                                                end:
                                                    appointments[index].endTime,
                                              )),
                                    ).then((value) async {
                                      await getDataFromWeb();
                                      setState(() {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (a, b, c) =>
                                                EventSlide(),
                                            transitionDuration:
                                                Duration(milliseconds: 400),
                                          ),
                                        );
                                      });
                                    });
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'ลบ',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.lightGreen[400],
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              'ยืนยันการลบ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text(
                                                  'ยกเลิก',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                              CupertinoDialogAction(
                                                  child: Text(
                                                    'ยืนยัน',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  onPressed: () {
                                                    deleteCalendar(
                                                            '${appointments[index].id}')
                                                        .then((value) =>
                                                            appointments
                                                                .removeAt(
                                                                    index))
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context))
                                                        .then((value) =>
                                                            setState(() {}))
                                                        .then((value) =>
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar));
                                                  })
                                            ],
                                          );
                                        });
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'ปิด',
                                  color: Colors.grey,
                                  icon: Icons.close,
                                  onTap: () {},
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            height: 5,
                          ),
                        ))),
                    //FloatingActionButton สำหรับเพิ่มรอบการแสดง
                  ],
                ),
              );
            } else {
              return new Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddWork()),
          ).then((value) async {
            await getDataFromWeb();
            setState(() {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (a, b, c) => EventSlide(),
                  transitionDuration: Duration(milliseconds: 100),
                ),
              );
            });
          });
        },
        backgroundColor: HexColor("#697825"),
        child: const Icon(Icons.add),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      setState(() {
        appointments = calendarTapDetails.appointments!.cast<Appointment>();
      });
    }
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

import 'dart:convert';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/showMan/addShow.dart';
import 'package:animal_welfare/screens/role/showMan/showDetail.dart';
import 'package:animal_welfare/screens/role/showMan/updateShow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

class AllShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllShowState();
  }
}

class _AllShowState extends State<AllShow> {
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

  Future<List<Appointment>> getDataFromWeb() async {
    String? token = await storage.read(key: 'token');
    var data = await http.get(Uri.parse("$endPoint/api/getShow"),
        headers: {"authorization": 'Bearer $token'});
    var jsonData = jsonDecode(data.body);
    // print(data.body);
    // print(jsonData);

    final List<Appointment> appointments = <Appointment>[];

    // print('before loop');
    for (var data in jsonData) {
      Appointment meetingData = Appointment(
          subject: data['showName'],
          startTime: _convertDateFromString(data['startDate']),
          endTime: _convertDateFromString(data['endDate']),
          location: data['location'],
          color: Colors.green,
          id: data['showID'],
          notes: data['totalAudience']);

      appointments.add(meetingData);
    }
    // print('after loop');

    return appointments;
  }

  List<Appointment> appointments = <Appointment>[];

  Future deleteShow(String showID) async {
    print(showID);
    String? token = await storage.read(key: 'token');
    var response = await http.delete(
        Uri.parse('$endPoint/api/deleteShow/$showID'),
        headers: {"authorization": 'Bearer $token'});
    var jsonResponse = await json.decode(response.body);
    print(jsonResponse['message']);
  }

  final snackBar = SnackBar(content: Text('ลบข้อมูลแล้ว'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'รอบการแสดง',
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
            pageBuilder: (a, b, c) => AllShow(),
            transitionDuration: Duration(milliseconds: 400),
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
                      flex: 1,
                      child: SfCalendar(
                        dataSource: _DataSource(snapshot.data!),
                        view: CalendarView.month,
                        viewHeaderHeight: 40,
                        showNavigationArrow: true,
                        monthViewSettings:
                            MonthViewSettings(numberOfWeeksInView: 1),
                        onTap: calendarTapped,
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                            // color: Colors.black12,
                            child: ListView.separated(
                          padding: const EdgeInsets.all(2),
                          itemCount: appointments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              height: 60,
                              color: appointments[index].color,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowDetail(
                                              subject:
                                                  appointments[index].subject,
                                              end:
                                                  appointments[index].endTime,
                                              location: appointments[index]
                                                  .location,
                                              start: appointments[index]
                                                  .startTime,
                                              audience:
                                                  appointments[index].notes,
                                              id: appointments[index].id,
                                            )),
                                  ).then((value) => setState(() {}));
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
                                            height: 0.5, color: Colors.white),
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
                                      child:
                                          Text('${appointments[index].notes}',
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
                              ),
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
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShowScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowScreenState();
  }
}

class _ShowScreenState extends State<ShowScreen> {

  
  List<Appointment> _appointmentDetails = <Appointment>[];
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SfCalendar(
                view: CalendarView.month,
                dataSource: getCalendarDataSource(),
                monthViewSettings: MonthViewSettings(
                  numberOfWeeksInView: 1,
                ),
                onTap: calendarTapped,
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                    color: Colors.black12,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(2),
                      itemCount: _appointmentDetails.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: EdgeInsets.all(2),
                            height: 60,
                            color: _appointmentDetails[index].color,
                            child: ListTile(
                              leading: Column(
                                children: <Widget>[
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? ''
                                        : '${DateFormat('hh:mm a').format(_appointmentDetails[index].startTime)}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        height: 1.7),
                                  ),
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? 'All day'
                                        : '',
                                    style: TextStyle(
                                        height: 0.5, color: Colors.white),
                                  ),
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? ''
                                        : '${DateFormat('hh:mm a').format(_appointmentDetails[index].endTime)}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                  child: Text(
                                      '${_appointmentDetails[index].notes}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              title: Container(
                                  child: Text(
                                      '${_appointmentDetails[index].subject}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white))),
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 5,
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      setState(() {
        _appointmentDetails =
            calendarTapDetails.appointments!.cast<Appointment>();
      });
    }
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      notes: '45',
      color: Color(0xFFfb21f66),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -2, hours: 4)),
      endTime: DateTime.now().add(Duration(days: -2, hours: 5)),
      subject: 'Development Meeting   New York, U.S.A',
      notes: '45',
      color: Color(0xFFf527318),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -2, hours: 3)),
      endTime: DateTime.now().add(Duration(days: -2, hours: 4)),
      subject: 'Project Plan Meeting   Kuala Lumpur, Malaysia',
      notes: '45',
      color: Color(0xFFfb21f66),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -2, hours: 2)),
      endTime: DateTime.now().add(Duration(days: -2, hours: 3)),
      subject: 'Support - Web Meeting   Dubai, UAE',
      notes: '45',
      color: Color(0xFFf3282b8),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -2, hours: 1)),
      endTime: DateTime.now().add(Duration(days: -2, hours: 2)),
      subject: 'Project Release Meeting   Istanbul, Turkey',
      notes: '45',
      color: Color(0xFFf2a7886),
    ));
    appointments.add(Appointment(
        startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
        endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
        subject: 'Release Meeting',
        notes: '45',
        color: Colors.lightBlueAccent,
        isAllDay: true));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 2, days: -4)),
      endTime: DateTime.now().add(const Duration(hours: 4, days: -4)),
      subject: 'Performance check',
      notes: '45',
      color: Colors.amber,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 11, days: -2)),
      endTime: DateTime.now().add(const Duration(hours: 12, days: -2)),
      subject: 'Customer Meeting   Tokyo, Japan',
      notes: '45',
      color: Color(0xFFffb8d62),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
      endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
      subject: 'Retrospective',
      notes: '45',
      color: Colors.purple,
    ));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

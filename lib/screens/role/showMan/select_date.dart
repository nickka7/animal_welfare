import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';

class SelectedDate extends StatefulWidget {
  const SelectedDate({Key? key}) : super(key: key);

  @override
  _SelectedDateState createState() => _SelectedDateState();
}

class _SelectedDateState extends State<SelectedDate> {
  final List<Map<String, dynamic>> _todaysEvents = [
    {
      "time": "9.00 - 10.00",
      "name": "โลมา",
      "visitors": "150",
      "date": "7 ธันวาคม 2564"
    },
    {"time": "11.00 - 12.00", "name": "ช้าง", "visitors": "40"},
    {"time": "13.00 - 14.00", "name": "ลิง", "visitors": "75"},
    {"time": "14.00 - 15.00", "name": "โลมา", "visitors": "รอบถัดไป"},
    {"time": "15.00 - 16.00", "name": "ช้าง", "visitors": "รอบถัดไป"},
  ];

  DateTime _date = DateTime.now();

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 400,
              width: double.infinity,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        maximumYear: DateTime.now().year,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _date = val;
                                print(_date);
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: Text('ยืนยัน'),
                    onPressed: () => 
                    Navigator.of(ctx).pop(),

                  ),
                ],
              ),
            ));
  }



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
      body: Container(
        color: HexColor('#F2F2F2'),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('วันที่', style: TextStyle(fontSize: 18)),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${DateFormat("d MMMM yyyy", 'th').formatInBuddhistCalendarThai(_date)}",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 25,
                          width: 120,
                          child: Text('เวลา', style: TextStyle(fontSize: 18))),
                      SizedBox(
                          height: 25,
                          width: 100,
                          child:
                              Text('การแสดง', style: TextStyle(fontSize: 18))),
                      SizedBox(
                          height: 25,
                          width: 80,
                          child: Text('ผู้เข้าชม',
                              style: TextStyle(fontSize: 18))),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: HexColor('#697825'), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: _buildListView()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _todaysEvents.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 60,
              //color: Colors.amber[colorCodes[index]],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 50,
                      width: 120,
                      child: Text('${_todaysEvents[index]["time"].toString()}',
                          style: TextStyle(fontSize: 16))),
                  SizedBox(
                      height: 50,
                      width: 100,
                      child: Text('${_todaysEvents[index]["name"].toString()}',
                          style: TextStyle(fontSize: 16))),
                  SizedBox(
                      height: 50,
                      width: 80,
                      child: Text(
                          '${_todaysEvents[index]["visitors"].toString()}',
                          style: TextStyle(fontSize: 16))),
                ],
              ),
            ),
          );
        });
  }
}

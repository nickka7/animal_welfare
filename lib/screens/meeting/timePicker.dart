import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/meeting/timePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../model/meetingHis.dart';

class TimePicker extends StatefulWidget {
  final String? getbuild;
  final String? getroom;
  final String? getdate;
  const TimePicker(
      {Key? key,
      required this.getbuild,
      required this.getroom,
      required this.getdate})
      : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late FixedExtentScrollController scrollController;

  Future<void>? api;
  int index = 0;
  @override
  void initState() {
    super.initState();
    api = getTime();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    scrollController.dispose();
    super.dispose();
  }

  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  final allTime = [
    '09.00-10.00',
    '10.00-11.00',
    '11.00-12.00',
    '13.00-14.00',
    '14.00-15.00',
    '15.00-16.00'
  ];
  // List time = [];
  Future<bool> getTime() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('$endPoint/api/checkBooking?build=${widget.getbuild}&room=${widget.getroom}&date=${widget.getdate}'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData2 = json.decode(response.body)['message'];

    for (int i = 0; i < jsonData2.length; i++) {
      // time.add(jsonData2[i]['time']);
      allTime.removeWhere((element) => element == jsonData2[i]['time']);
      //time.add(jsonData2[i]['time']);
    }
    print(allTime);
    print(widget.getdate);
    return true;
  }

  Future<String?> uploadData(url, data) async {
    // print(file!.path);
    String? token = await storage.read(key: 'token');
    // ignore: unused_local_variable
    var request = http.post(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          'build': data['build'],
          'room': data['room'],
          'date': data['date'],
          'time': data['time'],
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'จองห้องประชุม',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<void>(
            future: api,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(children: [
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: _heading(
                                          'ข้อมูลที่เลือก', 35.0, 120.0)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildfont('วันที่ : ', '${widget.getdate}'),
                                _buildfont('ตึก : ', '${widget.getbuild}'),
                                _buildfont('ห้อง : ', '${widget.getroom}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'เวลา',
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 58,
                          width: double.infinity,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side:
                                    BorderSide(width: 1, color: Colors.black45),
                              ),
                              onPressed: () {
                                scrollController.dispose();
                                scrollController = FixedExtentScrollController(
                                    initialItem: index);
                                _timePicker(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    allTime[index].toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(height: 70),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Map<String, String?> data = {
                              'build': widget.getbuild,
                              'room': widget.getroom,
                              'date': widget.getdate,
                              'time': allTime[index].toString(),
                            };
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightGreen[400],
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                    content: Text(
                                      'ยืนยันการจองห้องประชุม',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text(
                                          'ยกเลิก',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      CupertinoDialogAction(
                                          child: Text(
                                            'ยืนยัน',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          onPressed: () {
                                            uploadData(
                                                    '${Constant().endPoint}/api/booking',
                                                    data)
                                                .then((value) {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              final snackBar = SnackBar(
                                                  content: Text(
                                                      'จองห้องประชุมเรียบร้อยแล้ว'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          })
                                    ],
                                  );
                                });
                          },
                          child: Text('เสร็จสิ้น',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              primary: HexColor('#697825')),
                        ),
                      ),
                    ]),
                  ),
                );
              } else {
                return new Center(child: new CircularProgressIndicator());
              }
            }));
  }

  void _timePicker(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 30,
                  scrollController: scrollController,
                  children: allTime
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.index = index;
                      final item = allTime[index];
                      print('selected $allTime');
                    });
                  },
                  diameterRatio: 1,
                  useMagnifier: true,
                  magnification: 1.3,
                ),
              ),
              CupertinoButton(
                child: Text('ยืนยัน'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildfont(var title, var data) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget _heading(var title, double h, double w) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          color: HexColor("#697825"),
          borderRadius: BorderRadius.all(Radius.circular(45))),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

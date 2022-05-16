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

class RoomPicker extends StatefulWidget {
  final String? getbuild;
  const RoomPicker({
    Key? key,
    required this.getbuild,
  }) : super(key: key);

  @override
  State<RoomPicker> createState() => _RoomPickerState();
}

class _RoomPickerState extends State<RoomPicker> {
  late FixedExtentScrollController scrollController;

  Future<void>? api;
  int index = 0;
  @override
  void initState() {
    super.initState();
    api = getshowRoom();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    scrollController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var inputFormat = DateFormat('yyyy-MM-dd');

  int indexRoom = 0;
  int indexDate = 0;


  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  List room = [];
  Future<bool> getshowRoom() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('$endPoint/api/showRoom?build=${widget.getbuild}'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData2 = json.decode(response.body)['data'];

    for (int i = 0; i < jsonData2.length; i++) {
      room.add(jsonData2[i]['room']);
    }
    print(room);
    return true;
  }


  // Future<String?> uploadData(url, data) async {
  //   // print(file!.path);
  //   String? token = await storage.read(key: 'token');
  //   // ignore: unused_local_variable
  //   var request = http.post(Uri.parse(url),
  //       headers: <String, String>{
  //         "authorization": 'Bearer $token',
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       //   headers: {"authorization": 'Bearer $token'},
  //       body: jsonEncode(<String, String>{
  //         'builds': data['build'],
  //         'room': data['room'],
  //         'date': data['date'],
  //         'time': data['time'],
  //       }));
  // }

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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'ห้อง',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                height: 8,
              ),
              _room(),

              SizedBox(
                height: 8,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'วันที่',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 58,
                  width: double.infinity,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1, color: Colors.black45),
                      ),
                      onPressed: () {
                        scrollController.dispose();
                        scrollController =
                            FixedExtentScrollController(initialItem: indexDate);
                        _showDatePicker1(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${inputFormat.format(startDate)}',
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
              SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimePicker(
                            getbuild : widget.getbuild, getdate: '${inputFormat.format(startDate)}', getroom: room[indexRoom].toString(),
                          )),
                    );
                  },
                  child: Text('ถัดไป',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      primary: HexColor('#697825')),
                ),
              ),
              SizedBox(height: 40),
              //กราฟ
              SizedBox(height: 10),

              // charts1()
            ],
          ),
        ),
      ),
    );
  }

  _room() {
    return FutureBuilder<void>(
        future: api,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return Container(
              height: 58,
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.black45),
                  ),
                  onPressed: () {
                    scrollController.dispose();
                    scrollController =
                        FixedExtentScrollController(initialItem: indexRoom);
                    _roomPicker(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        room[indexRoom].toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      )
                    ],
                  )),
            );
          } else {
            return new Center(child: new CircularProgressIndicator());
          }
        });
  }

  void _roomPicker(context) {
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
                  children: room
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.indexRoom = index;
                      final item = room[index];
                      print('selected $item');
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

  void _showDatePicker1(ctx) {
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
                        // minimumDate: DateTime.now(),
                        initialDateTime: startDate,
                       // use24hFormat: true,
                        onDateTimeChanged: (val) {
                          setState(() {
                            startDate = val;
                            print(startDate.toString().split(" ")[0]);
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: Text('ยืนยัน'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
            ));
  }

  // Widget charts1() {
  //   if (report.isNotEmpty) {
  //     return Column(
  //       children: [
  //         Align(
  //             alignment: Alignment.topCenter,
  //             child: Text('แผนภูมิแสดงเปอร์เซ็นการฉีดวัคซีน')),
  //         Container(
  //           height: 300,
  //           width: 300,
  //           child: charts.BarChart(
  //             _createSampleData(),
  //             animate: true,
  //           ),
  //         ),
  //       ],
  //     );
  //   } else
  //     return Text("ไม่พบข้อมูล");
  // }
}

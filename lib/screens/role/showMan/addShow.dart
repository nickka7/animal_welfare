import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddShow extends StatefulWidget {
  const AddShow({
    Key? key,
  }) : super(key: key);

  @override
  _AddShowState createState() => _AddShowState();
}

class _AddShowState extends State<AddShow> {
  Future<void>? api;

  @override
  void initState() {
    super.initState();
    api = getShowType();
  }

  final _formKey = GlobalKey<FormState>();


  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var inputFormat = DateFormat('dd/MM/yyyy HH:mm');

  int index = 0;

  // final show = ['โชว์ช้าง', 'โชว์นกแก้ว', 'โชว์ลิง', 'โชว์แมวน้ำ'];

  List shows = [];
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  Future<bool> getShowType() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getAllShowType'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData2 = json.decode(response.body)['data'];

    for (int i = 0; i < jsonData2.length; i++) {
      shows.add(jsonData2[i]['showName']);
    }
    // print(jsonData2);
    print(shows);

    // var jsonData = showTypeFromJson(response.body);
    // print('1');
    // print('jsonData ${jsonData.data}');

    // List<ShowType> data = showTypeFromJson(response.body) as List<ShowType>;
    // setState(() {
    //   shows = data;
    //   print(shows);
    // });

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
          'showName': data['showName'],
          'startDate': data['startDate'],
          'endDate': data['endDate'],
        }));

    // print(request);
    // print(data['showName']);
    // print(data['startDate']);
    // print(data['endDate']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เพิ่มรอบการแสดง',
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
              return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'ชื่อการแสดง',
                                style: TextStyle(fontSize: 18),
                              )),
                          Container(
                            height: 58,
                            width: double.infinity,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: Colors.black45),
                                ),
                                onPressed: () {
                                  _showPicker(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      shows[index].toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'วัน-เวลาที่เริ่มการแสดง',
                                style: TextStyle(fontSize: 18),
                              )),
                          Container(
                            height: 58,
                            width: double.infinity,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: Colors.black45),
                                ),
                                onPressed: () {
                                  _showDatePicker1(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                          SizedBox(height: 30),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'วัน-เวลาที่จบการแสดง',
                                style: TextStyle(fontSize: 18),
                              )),
                          Container(
                            height: 58,
                            width: double.infinity,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: Colors.black45),
                                ),
                                onPressed: () {
                                  _showDatePicker2(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${inputFormat.format(endDate)}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(height: 70),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                bool pass = _formKey.currentState!.validate();
                                if (pass) {
                                  Map<String, String> data = {
                                    "showName": shows[index].toString(),
                                    "startDate": startDate.toString(),
                                    "endDate": endDate.toString()
                                  };
                                  uploadData(
                                          '${Constant().endPoint}/api/postShow',
                                          data)
                                      .then((value) {
                                    Navigator.of(context).pop();
                                    final snackBar = SnackBar(
                                        content: Text(
                                            'เพิ่มรอบการแสดงเรียบร้อยแล้ว'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                }
                              },
                              child: Text('เสร็จสิ้น',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  primary: HexColor('#697825')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return new Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }

  void _showPicker(context) {
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: shows
                      .map((item) => Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.index = index;
                      final item = shows[index];
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
                        mode: CupertinoDatePickerMode.dateAndTime,
                        maximumYear: DateTime.now().year,
                        initialDateTime: DateTime.now(),
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          setState(() {
                            startDate = val;
                            print(startDate);
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

  void _showDatePicker2(ctx) {
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
                        mode: CupertinoDatePickerMode.dateAndTime,
                        maximumYear: DateTime.now().year,
                        initialDateTime: DateTime.now(),
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          setState(() {
                            endDate = val;
                            print(endDate);
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
}

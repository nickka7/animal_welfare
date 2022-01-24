import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddShow extends StatefulWidget {
  const AddShow({Key? key}) : super(key: key);

  @override
  _AddShowState createState() => _AddShowState();
}

class _AddShowState extends State<AddShow> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController showController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final storage = new FlutterSecureStorage();

  Future<String?> uploadData(url, data) async {
    // print(file!.path);
    String? token = await storage.read(key: 'token');
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
        
    print(request);
    print(data['showName']);
    print(data['startDate']);
    print(data['endDate']);
  }

  DateTime _date1 = DateTime.now();
  DateTime _date2 = DateTime.now();
  var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
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
      body: SingleChildScrollView(
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
                  TextFormField(
                    controller: showController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกชื่อการแสดง";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade800, width: 2))),
                  ),
                  // TextFormField(
                  //   controller: startDateController,
                  //   validator: (String? input) {
                  //     if (input!.isEmpty) {
                  //       return "กรุณากรอกชื่อการแสดง";
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //               color: Colors.green.shade800, width: 2))),
                  // ),
                  // TextFormField(
                  //   controller: endDateController,
                  //   validator: (String? input) {
                  //     if (input!.isEmpty) {
                  //       return "กรุณากรอกชื่อการแสดง";
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //               color: Colors.green.shade800, width: 2))),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       'สถานที่',
                  //       style: TextStyle(fontSize: 18),
                  //     )),
                  // TextFormField(
                  //   controller: locationController,
                  //   validator: (String? input) {
                  //     if (input!.isEmpty) {
                  //       return "กรุณากรอกสถานที่";
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //               color: Colors.green.shade800, width: 2))),
                  // ),
                  SizedBox(
                    height: 30,
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
                          side: BorderSide(width: 1, color: Colors.black45),
                        ),

                        onPressed: () {
                          _showDatePicker1(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${inputFormat.format(_date1)}',
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
                          side: BorderSide(width: 1, color: Colors.black45),
                        ),
                        onPressed: () {
                          _showDatePicker2(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${inputFormat.format(_date2)}',
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
                            "showName": showController.text,
                            "startDate": _date1.toString(),
                            "endDate": _date2.toString()
                          };
                          uploadData(
                                  '${Constant().endPoint}/api/postShow', data)
                              .then((value) {
                            Navigator.of(context).pop();
                            final snackBar = SnackBar(
                                content: Text('เพิ่มรอบการแสดงเรียบร้อยแล้ว'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }
                      },
                      child: Text('เสร็จสิ้น',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          primary: HexColor('#697825')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                        onDateTimeChanged: (val) {
                          setState(() {
                            _date1 = val;
                            print(_date1);
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
                        onDateTimeChanged: (val) {
                          setState(() {
                            _date2 = val;
                            print(_date2);
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

import 'dart:convert';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class AddWork extends StatefulWidget {
  const AddWork({ Key? key }) : super(key: key);

  @override
  _AddWorkState createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  
    final _formKey = GlobalKey<FormState>();
  //TextEditingController userIDController = TextEditingController();
  TextEditingController calendarNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();


  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var inputFormat = DateFormat('dd/MM/yyyy HH:mm');

  
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
         // 'userID' : data['userID'],
          'calendarName': data['calendarName'],
          'location': data['location'],
          'startDate': data['startDate'],
          'endDate': data['endDate'],
        }));

    print(request);
   // print(data['userID']);
    print(data['calendarName']);
    print(data['startDate']);
    print(data['endDate']);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'เพิ่มงาน',
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
                        'งาน',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: calendarNameController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกงาน";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade800, width: 2))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                   Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'สถานที่',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: locationController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกสถานที่";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade800, width: 2))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'วัน-เวลาที่เริ่มงาน',
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
                        'วัน-เวลาที่จบงาน',
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
                           // "userID": userIDController.text,
                            "calendarName": calendarNameController.text,
                           "location": locationController.text,
                            "startDate": startDate.toString(),
                            "endDate": endDate.toString()
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
                                    'ยืนยันการเพิ่มกิจกรรม',
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
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      onPressed: () {
                                            uploadData(
                                  '${Constant().endPoint}/api/postEvent', data)
                              .then((value) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            final snackBar = SnackBar(
                                content: Text('เพิ่มงานเรียบร้อยแล้ว'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                           );
                                        })                                  ],
                                );
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
                       use24hFormat: true,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        maximumYear: DateTime.now().year,
                        initialDateTime: DateTime.now(),
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
                       use24hFormat: true,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        maximumYear: DateTime.now().year,
                        initialDateTime: DateTime.now(),
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
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../haxColor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:animal_welfare/constant.dart';

class CalendarUpdate extends StatefulWidget {
  final String subject;
  final String? location;
  final DateTime start;
  final DateTime end;
  final Object? id;
  const CalendarUpdate(
      {Key? key,
      required this.subject,
      required this.location,
      required this.start,
      required this.end,
      required this.id})
      : super(key: key);

  @override
  State<CalendarUpdate> createState() => _CalendarUpdateState();
}

class _CalendarUpdateState extends State<CalendarUpdate> {
  TextEditingController calendarNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();


  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var inputFormat = DateFormat('dd/MM/yyyy HH:mm');

  final storage = new FlutterSecureStorage();

  Future<String?> uploadData(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    //ถ้าไม่ได้เลือกรูปก็ไม่ต้องอัพรูป

    request.fields['scheduleName'] = data['scheduleName'];
    request.fields['location'] = data['location'];
    request.fields['startDate'] = data['startDate'];
    request.fields['endDate'] = data['endDate'];
    Map<String, String> headers = {
      "authorization": "Bearer $token",
      // "Content-Disposition": "attachment;filename=1.png",
      // "Content-Type": "image/png"
    };
    request.headers
        .addAll(headers); //['authorization'] = data['Bearer $token'];
    var res = await request.send();
    print('${res.reasonPhrase}test');
    return res.reasonPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CalendarID: ${widget.id}',
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
              // key: _formKey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'กิจกรรม',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: calendarNameController,
                    decoration: InputDecoration(
                        hintText: '${widget.subject}',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade800, width: 2))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'สถานที่',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '${widget.location}',
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, String> data = {
                          "scheduleName": calendarNameController.text,
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
                                  'ยืนยันการแก้ไข',
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
                                                '${Constant().endPoint}/api/updateMySchedule/${widget.id}',
                                                data)
                                            .then((value) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        });
                                      })
                                ],
                              );
                            });
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
                        initialDateTime: widget.start,
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
                        initialDateTime: widget.end,
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

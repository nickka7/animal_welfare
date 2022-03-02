import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddMedical extends StatefulWidget {
  final String animalID;
  const AddMedical({Key? key, required this.animalID}) : super(key: key);

  @override
  _AddMedicalState createState() => _AddMedicalState();
}

class _AddMedicalState extends State<AddMedical> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  Future<String?> uploadData(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.post(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          'medicalName': data['medicalName'],
          'detail': data['detail'],
        }));

    print(request);
    print(data['medicalName']);
    print(data['detail']);
    // print(data['endDate']);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เพิ่มการรักษา',
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
                        'การรักษา',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: nameController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกการรักษา";
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
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'รายละเอียด',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: detailController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกรายละเอียด";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade800, width: 2))),
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
                            "medicalName": nameController.text,
                            "detail": detailController.text
                          };
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.lightGreen[400],
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: Text(
                                    'ยืนยันการเพิ่มการรักษา',
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
                                                  '${Constant().endPoint}/api/postMedicalData/${widget.animalID}',
                                                  data)
                                              .then((value) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            setState(() {

                                            });
                                            final snackBar = SnackBar(
                                                content: Text(
                                                    'เพิ่มการรักษาเรียบร้อยแล้ว'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          });
                                        })
                                  ],
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
}

import 'dart:convert';
import 'dart:io';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:animal_welfare/constant.dart';

class StatusUpdate extends StatefulWidget {
  final String maintenanceID;
  final String maintenanceDetail;
  final String location;
  final String status;

  const StatusUpdate(
      {Key? key,
      required this.maintenanceID,
      required this.maintenanceDetail,
      required this.location,
      required this.status})
      : super(key: key);

  @override
  _StatusUpdateState createState() => _StatusUpdateState();
}

class _StatusUpdateState extends State<StatusUpdate> {
  int index = 0;
  final status = [
    'รอดำเนินการ',
    'ซ่อมแล้ว',
  ];

  final storage = new FlutterSecureStorage();

  Future<String?> uploadImageAndData(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    //ถ้าไม่ได้เลือกรูปก็ไม่ต้องอัพรูป

    request.fields['status'] = data['status'];
    // request.fields['location'] = data['location'];
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

  Future<String?> updateStatus(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.MultipartRequest('PUT', Uri.parse(url));

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
          'maintenanceID: ${widget.maintenanceID}',
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
            child: Column(
              children: [information()],
            ),
          ),
        ),
      ),
    );
  }

  Widget information() {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildfont('รหัส : ', '${widget.maintenanceID}'),
                  _buildfont('ปัญหา : ', '${widget.maintenanceDetail}'),
                  _buildfont('สถานที่ : ', '${widget.location}'),
                  _buildfont('สถานะ : ', '${widget.status}'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              'สถานะ',
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
                _statusPicker(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status[index],
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
                "status": status[index].toString(),
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
                              updateStatus(
                                      '${Constant().endPoint}/api/updateStatusMaintenance?maintenanceID=${widget.maintenanceID}&status=${status[index]}',
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
        )
      ],
    );
  }

  void _statusPicker(context) {
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
                  children: status
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index1) {
                    setState(() {
                      this.index = index1;
                      final item = status[index1];
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
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:animal_welfare/model/doorLocation_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'constant.dart';
import 'model/getMyCheckIn_test.dart';

class CheckinTest extends StatefulWidget {
  const CheckinTest({Key? key}) : super(key: key);

  @override
  State<CheckinTest> createState() => _CheckinTestState();
}

class _CheckinTestState extends State<CheckinTest> {
  @override
  void initState() {
    getDoorLocation();
    getMyLocations();
    super.initState();
  }

  // Future<GetMyCheckInTest> myData = getMyLocations();
  String? checkInDoor;
  Position? userLocation;
  double myLat = 13.7746067;
  double myLng = 100.51713;
  late List door = [];
  double? distanceInMeters;
  final storage = new FlutterSecureStorage();

  distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude) {
    distanceInMeters = GeolocatorPlatform.instance.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    // print(distanceInMeters);
    return distanceInMeters;
  }

  // Future<GetLocation> getLocations() async {
  //   print('object');
  //   String? token = await storage.read(key: 'token');
  //   String endPoint = Constant().endPoint;
  //   var response = await http.get(Uri.parse('$endPoint/api/getLocation'),
  //       headers: {"authorization": 'Bearer $token'});
  //
  //   // print(response.body);
  //   var jsonData = GetLocation.fromJson(jsonDecode(response.body));
  //   print(jsonData.status);
  //   return jsonData;
  // }

  checkIn() async {
    // String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var request = http.post(Uri.parse('$endPoint/api/checkIn'),
        headers: <String, String>{
          "authorization":
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJaMDE5OTkiLCJyb2xlSUQiOiJaMDEiLCJyb2xlIjoiY2VvIiwiZmlyc3ROYW1lIjoi4LiT4Lix4LiQ4LiQ4LiQIiwibGFzdE5hbWUiOiLguJ7guIfguKjguKjguKjguYwiLCJpbWFnZSI6IlowMTk5OS5qcGVnIiwiaWF0IjoxNjUxMzMyMDYzLCJleHAiOjE2NTE1MDQ4NjN9.F4r3vRHzKXfI8IwFoOhhkGUg2aWrja0Yy1aw1iueH-Q',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          // 'userID' : data['userID'],
          'location_checkIn': checkInDoor!,
        }));
  }

  Future<GetMyCheckInTest> getMyLocations() async {
    // print('as');
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response =
        await http.get(Uri.parse('$endPoint/api/getCheckIn'), headers: {
      "authorization":
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJaMDE5OTkiLCJyb2xlSUQiOiJaMDEiLCJyb2xlIjoiY2VvIiwiZmlyc3ROYW1lIjoi4LiT4Lix4LiQ4LiQ4LiQIiwibGFzdE5hbWUiOiLguJ7guIfguKjguKjguKjguYwiLCJpbWFnZSI6IlowMTk5OS5qcGVnIiwiaWF0IjoxNjUxNDc0NDEyLCJleHAiOjE2NTE2NDcyMTJ9.WvGW714h5C6SCVCFoCsjqiROQt7-YnElRC3Qa5reQ_0'
    });
    var z = jsonDecode(response.body);
    // print(z);
    var jsonData = GetMyCheckInTest.fromJson(jsonDecode(response.body));
    // print(jsonData);
    return jsonData;
  }

  checkLocation() {
    // print('check Lo');
    for (var i in door) {
      // print(i);
      double distance =
          distanceBetween(myLat, myLng, i['latitude'], i['longitude']);
      print(distance);
      if (distance <= 4) {
        print('เข้างานในสวนสัตว์ ที่ประตู ${i['door']}');
        return checkInDoor = i['door'];
      }
    }
    print('เข้างานแบบ WFH');
    return checkInDoor = 'out';
  }

  //forEach เป็น void จึงไม่สามารถ return ค่าได้
  // door.forEach((element) {
  //   double distance = distanceBetween(
  //       myLat, myLng, element['latitude'], element['longitude']);
  //   print(distance);
  //   if (distance <= 4) {
  //     // Text('123');
  //     print('เข้างานในสวนสัตว์ ที่ประตู ${element['door']}');
  //   } else {
  //     print('เข้างานแบบ WFH');
  //   }
  // });

  Future<List> getDoorLocation() async {
    // String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response =
        await http.get(Uri.parse('$endPoint/api/getLocation'), headers: {
      "authorization":
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJaMDE5OTkiLCJyb2xlSUQiOiJaMDEiLCJyb2xlIjoiY2VvIiwiZmlyc3ROYW1lIjoi4LiT4Lix4LiQ4LiQ4LiQIiwibGFzdE5hbWUiOiLguJ7guIfguKjguKjguKjguYwiLCJpbWFnZSI6IlowMTk5OS5qcGVnIiwiaWF0IjoxNjUxNDc0NDEyLCJleHAiOjE2NTE2NDcyMTJ9.WvGW714h5C6SCVCFoCsjqiROQt7-YnElRC3Qa5reQ_0'
    });
    // print(response.body);
    // var a = DoorLocationTest.fromJson(jsonDecode(response.body));
    var b = jsonDecode(response.body);
    // print(b);
    return door = b['message'];
    // print(door);
    // return DoorLocationTest.fromJson(jsonDecode(response.body));
  }

  DateTime myDateTime = DateTime.now();

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat("d MMM yyyy    HH:mm", 'th');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkin Test'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await checkLocation();
                // print(checkInDoor);
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        // title: CircleAvatar(
                        //   radius: 30,
                        //   backgroundColor: Colors.lightGreen[400],
                        //   child: Icon(
                        //     Icons.check,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        content: Column(
                          children: [
                            Text(
                              'คุณได้ทำการเข้างาน',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              formatDateFromString(myDateTime.toString()),
                              // DateTime.now().toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            checkInDoor != 'out'
                                ? Text(
                                    'ภายในประตู $checkInDoor',
                                    style: TextStyle(fontSize: 16),
                                  )
                                : Text(
                                    'ภายนอกประตู',
                                    style: TextStyle(fontSize: 16),
                                  )
                          ],
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
                              onPressed: () async {
                                await checkIn();
                                await getMyLocations();
                                Navigator.pop(context);
                                setState(() {});
                              })
                        ],
                      );
                    });
              },
              child: Text('เข้างาน'),
            ),
          ),
          FutureBuilder(
              future: getMyLocations(),
              builder: (BuildContext context,
                  AsyncSnapshot<GetMyCheckInTest> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.message!.length,
                          itemBuilder: (context, index) {
                            return Text(
                                '${snapshot.data!.message![index].checkIn} ${snapshot.data!.message![index].locationCheckIn}');
                          }),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text('ERROR');
                } else {
                  return Text('Fail');
                }
              }),
        ],
      ),
    );
  }
}

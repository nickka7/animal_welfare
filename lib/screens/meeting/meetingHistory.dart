import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/history_booking.dart';
import 'package:animal_welfare/screens/meeting/roomPicker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/meetingHis.dart';
import 'buildPicker.dart';

class MeetingHistory extends StatefulWidget {
  const MeetingHistory({Key? key}) : super(key: key);

  @override
  State<MeetingHistory> createState() => _MeetingHistoryState();
}

class _MeetingHistoryState extends State<MeetingHistory> {
  final storage = new FlutterSecureStorage();

  Future<MeetingRoom> getStorybooking() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/historyBookingRoom'),
        headers: {"authorization": 'Bearer $token'});

    print("123${response.body}");
    var jsonData = MeetingRoom.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F7F7F7"),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: HexColor("#697825")),
          ),
          centerTitle: true,
          title: Text('จองห้องประชุม',
              style: const TextStyle(color: Colors.white)),
        ),
        body: 
        
        RefreshIndicator(
          onRefresh: () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (a, b, c) => MeetingHistory(),
            transitionDuration: Duration(milliseconds: 400),
          ),
        ),
          child: FutureBuilder(
            future: getStorybooking(),
            builder: (BuildContext context, AsyncSnapshot<MeetingRoom> snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.message?.length,
                        itemBuilder: (context, index) {
                          return cardDetail('${snapshot.data!.message![index].build}', '${snapshot.data!.message![index].room}', '${snapshot.data!.message![index].date}', '${snapshot.data!.message![index].time}');
                        }),
                    flex: 15,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: HexColor("#C4C4C4"),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,
                        )
                      ]),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        // textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: HexColor("#697825"),
                        child: Text('จองห้องประชุม',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            )),
                        onPressed: () => {
                         Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BuildPicker()),
                            ).then((value) =>
                                setState(() {}))
                        },
                      ),
                    ),
                    flex: 2,
                  ),
                ]);
              } else {
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }

  cardDetail(String building, String room, String date, String time) {
    return Container(
      decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#697825")),
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
      width: 150.0,
      height: 100.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'อาคาร ',
                  style: TextStyle(
                    color: HexColor("#000000"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  building,
                  style: TextStyle(
                    color: HexColor("#34C1FF"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' ห้อง ',
                  style: TextStyle(
                    color: HexColor("#000000"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  room,
                  style: TextStyle(
                    color: HexColor("#34C1FF"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('     '),
                Icon(Icons.circle, color: HexColor('#000000'), size: 10),
                Text('  '),
                Text(
                  date,
                  style: TextStyle(
                    color: HexColor("#000000"),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('     '),
                Icon(Icons.circle, color: HexColor('#000000'), size: 10),
                Text('  '),
                Text(
                  time,
                  style: TextStyle(
                    color: HexColor("#000000"),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

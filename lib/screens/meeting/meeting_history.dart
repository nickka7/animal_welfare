// import 'package:animal_welfare/api/get_sky_line.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/history_booking.dart';



import 'package:animal_welfare/screens/meeting/meeting_booking.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constant.dart';

class MyMeetingHistory extends StatefulWidget {
  const MyMeetingHistory({ Key? key }) : super(key: key);

  @override
  _MyMeetingHistoryState createState() => _MyMeetingHistoryState();
}

class _MyMeetingHistoryState extends State<MyMeetingHistory> {
final storage = new FlutterSecureStorage();

  Future<HistoryBooking> getStorybooking() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/historyBookingRoom'),
        headers: {"authorization": 'Bearer $token'});

    print(response.body);
    var jsonData = HistoryBooking.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }

  // Future<HistoryBooking> getStorybooking() async{
  //   Uri url = Uri.parse(
  //     'https://flight-data4.p.rapidapi.com/get_area_flights?latitude=13.0003022&longitude=96.9923911');
    
  //   http.Response response = await http.get(url, headers: {
  //     "x-rapidapi-host": "flight-data4.p.rapidapi.com",
  //     "x-rapidapi-key": "8995a8cc8cmshe10cb8d52233a86p11c409jsn27b93c7616c2",
  //     "Content-Type": "application/json"
  //   });

  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     return HistoryBooking.fromJson(json.decode(response.body));
      

  //   } else {
  //     throw Exception('Failed');
  //   }
  // }

  // Future<GetFlightArea> loadFlightArea() async{
  //   Uri url = Uri.parse(
  //     'https://flight-data4.p.rapidapi.com/get_area_flights?latitude=13.0003022&longitude=96.9923911');
    
  //   http.Response response = await http.get(url, headers: {
  //     "x-rapidapi-host": "flight-data4.p.rapidapi.com",
  //     "x-rapidapi-key": "8995a8cc8cmshe10cb8d52233a86p11c409jsn27b93c7616c2",
  //     "Content-Type": "application/json"
  //   });

  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     return GetFlightArea.fromJson(json.decode(response.body));
      

  //   } else {
  //     throw Exception('Failed');
  //   }
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
        color: HexColor("#697825")
        ),
        ),
          centerTitle: true,
          title: Text('จองห้องประชุม',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<HistoryBooking> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              CircularProgressIndicator();
              print ('circle waiting');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              print ('Done');

              return
      Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('รายการจองห้องประชุม',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                      ),
                ],
              ),
              ),
              flex: 2,
          ),
            Expanded(
              child: 
              ListView.builder(
                itemCount: snapshot.data?.status.length,
                itemBuilder: (context, i){
                  return SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#697825")),
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      child: 
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                cardDetail('${snapshot.data?.message[i].build ?? 'ไม่พบข้อมูล'}', '${snapshot.data?.message[i].room ?? 'ไม่พบข้อมูล'}','date', '${snapshot.data?.message[i].time ?? 'ไม่พบข้อมูล'}'),
                                // ${snapshot.data?.flights?[i].airline ?? 'ไม่พบข้อมูล'}', 'room','date', 'time
                                // ${snapshot.data?.message[i].build ?? 'ไม่พบข้อมูล'}', 'room','date', 'time
                              ],
                            )
                          ),
                    //   ],
                    // ),
                       
                                  ),
                  );
                }
              ),
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
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 15),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 4.0,)]
                      ),
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
                            )
                            ),
                            onPressed: () => {
                              Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context) => const MyBookingMeeting()),
                              ),
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
                                  // );
                                    
                          //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          //     builder: (BuildContext context) => CountryScreens());
                          // Navigator.of(context).push(materialPageRoute);
                                },
                        ),
                  ),
                  flex: 2,
            ),
        ]
      );
      } else {
              return Text('ไม่สามารถโหลดข้อมูลได้');
            }
          },
          future: getStorybooking(),
      )
    );
  }


  Expanded cardDetail(String building, String room, String date, String time) {
    return Expanded(
      
      child: Container(
        width: 150.0,
        height: 100.0,
        //color: Colors.blue,
        margin: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 5
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

              Row(
                children: [
                  Text ('อาคาร ',
                  style: TextStyle(
                    color: HexColor("#000000"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    ),  
                  ),
                  Text (building,
                  style: TextStyle(
                    color: HexColor("#34C1FF"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    ),  
                  ),
                  Text (' ห้อง ',
                  style: TextStyle(
                    color: HexColor("#000000"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    ),  
                  ),
                  Text (room,
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
                  Text ('     '),
                  Icon(
                        Icons.circle,
                        color: HexColor('#000000'),
                        size: 10),
                  Text ('  '),
                  Text (date,
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
                  Text ('     '),
                  Icon(
                        Icons.circle,
                        color: HexColor('#000000'),
                        size: 10),
                  Text ('  '),
                  Text (time,
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
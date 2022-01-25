import 'package:animal_welfare/screens/meeting/meeting_history.dart';
import 'package:flutter/material.dart';

import 'package:animal_welfare/haxColor.dart';

class MeetingSuccess extends StatefulWidget {
  const MeetingSuccess({ Key? key }) : super(key: key);

  @override
  _MeetingSuccessState createState() => _MeetingSuccessState();
}

class _MeetingSuccessState extends State<MeetingSuccess> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text('สำเร็จ!',
                  style: TextStyle(
                  color: HexColor("#28B446"),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                )),
                Text('คุณได้ยืนยันการห้องประชุม',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
                ],
              ),
            ),
          ),
          Icon(Icons.flag_outlined,
          size: 120,
          color: HexColor("#28B446"),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text('วัน',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
                Text('อาคาร ห้อง',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
                Text('เวลา',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
                ],
              ),
            ),
          ),
          
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  width: double.infinity,
                  height: 50,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                          // textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                            color: HexColor("#697825"),
                            child: Text('เสร็จสิ้น',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              )
                              ),
                              onPressed: () => {
                                Navigator.push(
                                context,MaterialPageRoute(
                                  builder: (context) => const MyMeetingHistory()),
                                ),
                              },
                  ),
                ),
        ],),
      
    );
  }
}
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';


class MyBookingMeeting extends StatefulWidget {
  const MyBookingMeeting({ Key? key }) : super(key: key);

  @override
  _MyBookingMeetingState createState() => _MyBookingMeetingState();
}

class _MyBookingMeetingState extends State<MyBookingMeeting> {
  int _selectionbuild = 0;
  int _selectionroom = 0;
  int _selection = 0;

      selectTime(int timeSelected) {
       setState(() {
       _selection = timeSelected;
          });
         }

  DateTime myDateTime = DateTime.now();

  void _showDatePicker(ctx) {
    // Intl.defaultLocale = 'th';
    // initializeDateFormatting('th');
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
                        mode: CupertinoDatePickerMode.date,
                        maximumYear: DateTime.now().yearInBuddhistCalendar,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            myDateTime = val;
                            print(myDateTime);
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

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th');
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
      body: Container(
        color: HexColor('#F2F2F2'),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //   child: 
                Text('วันที่', style: TextStyle(fontSize: 18)),
                // flex: 1),
              // Expanded(
              //   child: 
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _showDatePicker(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${DateFormat("d MMMM yyyy", 'th').formatInBuddhistCalendarThai(myDateTime)}",
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              //   flex: 1,
              // ),
              Expanded(
                child: 
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.circle,
                        color: HexColor('#C4C4C4'),
                        size: 20),
                      Text('ว่าง      ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                        ),
                      Icon(
                        Icons.circle,
                        color: HexColor('#FBBB00'),
                        size: 20),
                      Text('ไม่ว่าง      ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                        ),
                      Icon(
                        Icons.circle,
                        color: HexColor('#BFF073'),
                        size: 20),
                      Text('ทำการจอง      ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                        ),  
                    ],
                  ),
                ),
                flex: 3,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.symmetric(horizontal: 30),
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           color: HexColor("#C4C4C4"),
              //           borderRadius: BorderRadius.circular(20.0)),
              //         child: Icon(
              //           Icons.home_work_outlined,
              //           color: HexColor('#000000'),
              //           size: 30),
              //       ),
              //       Container(
              //         margin: EdgeInsets.symmetric(horizontal: 30),
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           color: HexColor("#C4C4C4"),
              //           borderRadius: BorderRadius.circular(20.0)),
              //         child: Icon(
              //           Icons.home_work_outlined,
              //           color: HexColor('#000000'),
              //           size: 30),
              //       ),
              //       Container(
              //         margin: EdgeInsets.symmetric(horizontal: 30),
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           color: HexColor("#C4C4C4"),
              //           borderRadius: BorderRadius.circular(20.0)),
              //         child: Icon(
              //           Icons.home_work_outlined,
              //           color: HexColor('#000000'),
              //           size: 30),
              //       ),
                    
              //     ],
              //   ),
              // ),
              // Expanded(
              //         child: Container(
              //           child: GridView.builder(
              //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 4),
              //               itemBuilder: (context, index) {
              //                 return Container(
              //           margin: EdgeInsets.symmetric(horizontal: 30),
              //           height: 50,
              //           width: 50,
              //           decoration: BoxDecoration(
              //             color: HexColor("#C4C4C4"),
              //             borderRadius: BorderRadius.circular(20.0)),
              //           child: Icon(
              //             Icons.home_work_outlined,
              //             color: HexColor('#000000'),
              //             size: 30),
              //         );
              //               },
              //         ),
              //         ),
              //         flex: 2,
              //       ),
              Expanded(
                child: Container(
                  child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(5, (int index) {
                    return  Column(
                      children: [
                        InkWell(
                          onTap: () {
                                  setState(() {
                                    _selectionbuild = 1;
                                  });
                                },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 18),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: _selectionbuild == 1 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 4.0,)]
                                ),
                              child: Icon(
                                Icons.home_work_outlined,
                                color: HexColor('#000000'),
                                size: 30),
                            ),
                        ),
                          Text('อาคาร x',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                            ),
                      ],
                    );
                    }),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Container(
                  child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(10, (int index) {
                    return  Column(
                      children: [
                        InkWell(
                          onTap: () {
                                  setState(() {
                                    _selectionroom = 1;
                                  });
                                },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              width: 75,
                              decoration: BoxDecoration(
                                color: _selectionroom == 1 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 4.0,)]
                                ),
                              child: Center(
                                child: Text('ห้อง xxx',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                        ),
                          
                      ],
                    );
                    }),
                  ),
                ),
                flex: 2,
              ),
              // Expanded(
              //   child: Container(
              //     child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: List.generate(10, (int index) {
              //       return  Column(
              //         children: [
              //           Container(
              //               margin: EdgeInsets.symmetric(horizontal: 10),
              //               height: 30,
              //               width: 75,
              //               decoration: BoxDecoration(
              //                 color: HexColor("#C4C4C4"),
              //                 borderRadius: BorderRadius.circular(20.0),
              //                 boxShadow: [BoxShadow(
              //                   color: Colors.black38,
              //                   offset: Offset(0.0, 4.0),
              //                   blurRadius: 4.0,)]
              //                 ),
              //               child: Center(
              //                 child: Text('เวลา xxx',
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 16.0,
              //                 fontWeight: FontWeight.w500),
              //                 ),
              //               ),
              //               // onTap: ()  {
              //               //   context.read(selectedTime)
              //               //  ),
              //               // }
              //             ),
                          
              //         ],
              //       );
              //       }),
              //     ),
              //   ),
              //   flex: 4,
              // ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30,right: 20),
                    // padding: EdgeInsets.all(30),
                    
                    child: ListView(
                      // scrollDirection: Axis.vertical,
                      children: List.generate(1, (int index) {
                    return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 1;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 1 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 1,
                                    ),
                                    Text("09:00 - 09:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 2;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 2 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 2,
                                    ),
                                    Text("09:30 - 10:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 3;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 3 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 3,
                                    ),
                                    Text("10:00 - 10:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 4;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 4 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 4,
                                    ),
                                    Text("10:30 - 11:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 5;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 5 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 5,
                                    ),
                                    Text("11:00 - 11:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 6;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 6 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 6,
                                    ),
                                    Text("11:30 - 12:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 7;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 7 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 7,
                                    ),
                                    Text("12:00 - 12:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 8;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 8 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 8,
                                    ),
                                    Text("12:30 - 13:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 9;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 9 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 9,
                                    ),
                                    Text("13:00 - 13:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 10;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 10 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 10,
                                    ),
                                    Text("13:30 - 14:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 11;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 11 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 11,
                                    ),
                                    Text("14:00 - 14:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 12;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 12 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 12,
                                    ),
                                    Text("14:30 - 15:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 13;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 13 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 13,
                                    ),
                                    Text("15:00 - 15:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 14;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 14 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 14,
                                    ),
                                    Text("15:30 - 16:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 15;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 15 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 15,
                                    ),
                                    Text("16:00 - 16:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 16;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 16 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 16,
                                    ),
                                    Text("16:30 - 17:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 17;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 17 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 17,
                                    ),
                                    Text("17:00 - 17:30",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 18;
                                  });
                                },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10, bottom: 10),
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 4.0,)],
                                        color: _selection == 18 ? HexColor('#BFF073') : HexColor("#C4C4C4"),
                                    ),
                                  ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor: Colors.white,
                                      groupValue: _selection,
                                      onChanged: selectTime(_selection),
                                      value: 18,
                                    ),
                                    Text("17:30 - 18:00",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              ),     
                            ],
                          ),
                        ],
                    );
                    }),
                  ),
                ),
                flex: 9,
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
                margin: EdgeInsets.only(bottom: 5),
                  // height: 50,
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
                          child: Text('ยืนยันการจอง',
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
          ),
        ),
      ),
      
    );
  }
}
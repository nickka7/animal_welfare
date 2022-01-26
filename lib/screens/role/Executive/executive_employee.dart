import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/get_sky_line.dart';
import 'package:animal_welfare/screens/role/Executive/caretaker_total.dart';
import 'package:animal_welfare/screens/role/Executive/caretaker_woker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuantityEmployee extends StatefulWidget {
  const QuantityEmployee({ Key? key }) : super(key: key);

  @override
  _QuantityEmployeeState createState() => _QuantityEmployeeState();
}

class _QuantityEmployeeState extends State<QuantityEmployee> {

  DateTime myDateTime = DateTime.now();

  Future<GetFlightArea> loadFlightArea() async{
    Uri url = Uri.parse(
      'https://flight-data4.p.rapidapi.com/get_area_flights?latitude=13.0003022&longitude=96.9923911');
    
    http.Response response = await http.get(url, headers: {
      "x-rapidapi-host": "flight-data4.p.rapidapi.com",
      "x-rapidapi-key": "8995a8cc8cmshe10cb8d52233a86p11c409jsn27b93c7616c2",
      "Content-Type": "application/json"
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      return GetFlightArea.fromJson(json.decode(response.body));
      

    } else {
      throw Exception('Failed');
    }
  }

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
          title: Text('จำนวนเจ้าหน้าที่',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<GetFlightArea> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              CircularProgressIndicator();
              print ('circle waiting');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              print ('Done');

              return
      Container(
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
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: HexColor("#E2E9F1"),
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text ('ผู้ดูแลสัตว์',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            ),  
                          ),
                          
                          Row(
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#697825"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerWoker()));

                                    },
                              ),
                              Text (' / ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                ),  
                              ),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#C4C4C4"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerTotal()));

                                    },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: HexColor("#E2E9F1"),
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text ('สัตวแพทย์',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            ),  
                          ),
                          
                          Row(
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#697825"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                              Text (' / ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                ),  
                              ),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#C4C4C4"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: HexColor("#E2E9F1"),
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text ('นักวิจัย',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            ),  
                          ),
                          
                          Row(
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#697825"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                              Text (' / ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                ),  
                              ),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#C4C4C4"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: HexColor("#E2E9F1"),
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text ('นักเพาะพันธุ์',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            ),  
                          ),
                          
                          Row(
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#697825"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                              Text (' / ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                ),  
                              ),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#C4C4C4"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: HexColor("#E2E9F1"),
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text ('ผู้ดูแลการแสดง',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            ),  
                          ),
                          
                          Row(
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#697825"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                              Text (' / ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                ),  
                              ),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: HexColor("#C4C4C4"),
                                  child: Text('count',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                                    onPressed: (){

                                    },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                      
                  //       );
                  //   },
                  // ),
                //   flex: 13,
                // ),
            ]
          ),
        ),
      );
      } else {
              return new Center(child: new CircularProgressIndicator());
            }
          },
          future: loadFlightArea(),
      )
    );
  }
}
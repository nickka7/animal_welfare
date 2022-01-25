import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/get_sky_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuantityVisitors extends StatefulWidget {
  const QuantityVisitors({ Key? key }) : super(key: key);

  @override
  _QuantityVisitorsState createState() => _QuantityVisitorsState();
}

class _QuantityVisitorsState extends State<QuantityVisitors> {
  
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
          title: Text('จำนวนผู้เข้าชมสะสม',
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
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i){
                    return Container(
                        decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#697825")),
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,)]
                        ),
                    
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 7
                        ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ignore: deprecated_member_use
                              FlatButton(
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Flexible(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            timeDetail(DateTime.now(), 5),
                                            // '${snapshot.data?.flights?[i].airline ?? 'ไม่พบข้อมูล'}'
                                          ],
                                        )
                                       ), 
                                    ),
                                  ),
                                  onPressed: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => QuantityEmployee()));
                                  },
                              ),
                            ],
                          ),
                        );
                    },
                  ),
                  flex: 13,
                ),
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

  Expanded timeDetail(DateTime date, int count) {
    return Expanded(
      
      child: Container(
        width: 150.0,
        height: 70.0,
        //color: Colors.blue,
        // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text ("${DateFormat("d MMMM yyyy", 'th').formatInBuddhistCalendarThai(date)}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),  
            ),

            Row(
              children: [
                Text ('${NumberFormat("###,###").format(count)}',
                  style: TextStyle(
                    color: HexColor("#28B446"),
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                  ),  
                ),
                Text ('  คน',
                  style: TextStyle(
                    color: HexColor("#28B446"),
                    fontSize: 20.0,
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
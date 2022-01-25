
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';


class WorkTimeCheck extends StatefulWidget {
  const WorkTimeCheck({ Key? key }) : super(key: key);

  @override
  _WorkTimeCheckState createState() => _WorkTimeCheckState();
}

class _WorkTimeCheckState extends State<WorkTimeCheck> {

  DateTime myDateTime = DateTime.now();

  // var formatter = DateFormat("d MMMM yyyy", 'th');



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
          title: Text('เวลาเข้าออกงาน',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: Column(
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[HexColor("#697825"), HexColor("#F7F7F7")]
                ),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 4.0,)],
                ),
            // color: Colors.blue,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 170,
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //     colors: <Color>[HexColor("#C4F579"), HexColor("#F7F7F7")]
                  //     )
                  // ),
                  // color: HexColor("#BFF073"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30,top: 60),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 100),
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor("#697825"),
                          width: 10),
                        boxShadow: [BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 20.0,)],
                        shape: BoxShape.circle,
                         //  image: DecorationImage(
                         // fit: BoxFit.fill,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        colors: <Color>[HexColor("#FFFFFF"), HexColor("#D9E8FB")]
                        )
                              //image: NetworkImage('${dataWorld[i].countryInfo.flag}')
                        ),
                        child: Center(
                          child: Text('${DateFormat("HH : mm").format(myDateTime)}',
                          style: TextStyle(
                          color: HexColor("#1273EB"),
                          fontSize: 34.0,
                          fontWeight: FontWeight.w900))),
                     ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20,bottom: 50),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('${DateFormat("d MMM yyyy", 'th').formatInBuddhistCalendarThai(myDateTime)}',
                      // ${DateFormat("d MMMM yyyy", 'th').formatInBuddhistCalendarThai(myDateTime)}
                        style: TextStyle(
                        color: HexColor("#58837B"),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w900,
                      ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(left: 212),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                          color: HexColor("#1273EB"),),

                          Text ('location',
                          style: TextStyle(
                            color: HexColor("#1273EB"),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            ),
                            ),
                            
                          Icon(Icons.arrow_forward_ios,
                          color: HexColor("#1273EB"),),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            // height: double.infinity,
            // decoration: BoxDecoration(
            //   boxShadow: [BoxShadow(
            //     color: HexColor("#F7F7F7"),
            //     offset: Offset(0.0, 0.0),
            //     blurRadius: 4.0,
            //     spreadRadius: 2.5)],
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: HexColor("#DFDFDF"),
                  width: double.infinity,
                  height: 40,
                  child: Text('     ประวัติเวลาเข้างาน',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 100,
                  // color: Colors.blue,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i){
                      return
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ignore: deprecated_member_use
                              Container(
                                width: double.infinity,
                                  child: 
                                  
                                  Flexible(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        timeDetailIn(DateTime.now(), 'location', DateTime.now()),
                                        ],
                                      )
                                    ), 

                                  ),
                                  
                            ],
                          // ),
                        );
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: HexColor("#DFDFDF"),
                  width: double.infinity,
                  height: 40,
                  child: Text('     ประวัติเวลาออกงาน',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 100,
                  // color: Colors.blue,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i){
                      return
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ignore: deprecated_member_use
                              Container(
                                width: double.infinity,
                                  child: 
                                  
                                  Flexible(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        timeDetailOut(DateTime.now(), 'location', DateTime.now()),
                                        ],
                                      )
                                    ), 

                                  ),
                                  
                            ],
                          // ),
                        );
                    },
                  ),
                ),

              ],
            ),
          )
        ],
      )
    );
  }

  Expanded timeDetailIn(DateTime time, String location, DateTime date) {
    return Expanded(
      
      child: Container(
        // width: 150.0,
        // height: 30.0,
        // color: Colors.blue,
        margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

              Text ('${DateFormat("HH : mm").format(time)}',
              style: TextStyle(
                color: HexColor("#575757"),
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),  
            ),

            Row(
              children: [ 
                Icon(Icons.location_on_outlined,
                color: HexColor("#1273EB"),),

              Text (location,
              style: TextStyle(
                color: HexColor("#1273EB"),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),

              Text ('${DateFormat("d MMM yyyy", 'th').formatInBuddhistCalendarThai(date)}',
              // '${DateFormat("d MMMM yyyy", 'th').formatInBuddhistCalendarThai(date)}'
              style: TextStyle(
                color: HexColor("#575757"),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
 
          ],
      ),
      ),
    );
  }

  Expanded timeDetailOut(DateTime time, String location, DateTime date) {
    return Expanded(
      
      child: Container(
        // width: 150.0,
        // height: 30.0,
        // color: Colors.blue,
        margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

              Text ('${DateFormat("HH : mm").format(time)}',
              style: TextStyle(
                color: HexColor("#575757"),
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),  
            ),

            Row(
              children: [ 
                Icon(Icons.location_on_outlined,
                color: HexColor("#DD873C"),),

              Text (location,
              style: TextStyle(
                color: HexColor("#DD873C"),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),

              Text ('${DateFormat("d MMM yyyy", 'th').formatInBuddhistCalendarThai(date)}',
              style: TextStyle(
                color: HexColor("#575757"),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
 
          ],
      ),
      ),
    );
  }


}
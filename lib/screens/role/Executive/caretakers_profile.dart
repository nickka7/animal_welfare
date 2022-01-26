import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class CaretakesProfile extends StatefulWidget {
  const CaretakesProfile({ Key? key }) : super(key: key);

  @override
  _CaretakesProfileState createState() => _CaretakesProfileState();
}

class _CaretakesProfileState extends State<CaretakesProfile> {
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
          title: Text('ZOO ID',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              // Center(
                // child: 
                Container(
                        width: 125.0,
                        height: 125.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                                                          //  image: DecorationImage(
                                        // fit: BoxFit.fill,
                          color: Colors.black45,
                          //image: NetworkImage('${dataWorld[i].countryInfo.flag}')
                          )
                          ),
                    // ),
      
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ชื่อ',
                      style: TextStyle(
                        color: HexColor("#1273EB"),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        ),
                        ),
                      Text(' สกุล',
                      style: TextStyle(
                        color: HexColor("#1273EB"),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        ),
                        ),
                        
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text('ตำแหน่ง',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  ),
                  ),
              ),
      
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#697825")),
                  color: HexColor("#ECEFF0"),
                borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('ทำงาน',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('วัน',
                        style: TextStyle(
                          color: HexColor("#28B446"),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                        ),
                      )],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#697825")),
                  color: HexColor("#ECEFF0"),
                borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('ลาป่วย',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('วัน',
                        style: TextStyle(
                          color: HexColor("#4DB6AC"),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                        ),
                      )],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#697825")),
                  color: HexColor("#ECEFF0"),
                borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('ลากิจ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('วัน',
                        style: TextStyle(
                          color: HexColor("#DD873C"),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                        ),
                      )],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#697825")),
                  color: HexColor("#ECEFF0"),
                borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('ขาดงาน',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('วัน',
                        style: TextStyle(
                          color: HexColor("#F14336"),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                        ),
                      )],
                  ),
                ),
              ),
              
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#697825")),
                  color: HexColor("#ECEFF0"),
                borderRadius: BorderRadius.circular(5.0)),
                
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text('ข้อมูลพนักงาน',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                      ),
                      
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              dataDetailOne('วันเกิด', 'เพศ', 'ที่อยู่'),
                              ],
                              )
                              ),
                      ),
                               Divider(
                              //    height: 50,
                                 color: HexColor("#697825"),
                               ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text('ข้อมูลการติดต่อ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              dataDetailTwo('email', 'line id'),
                              ],
                              )
                          ),
                    ]
                ),
              ),
              )
                    ]
              ),
            ),
      )
      
    );

  }

  Expanded dataDetailOne(String birth, String gender, String address) {
    return Expanded(
      
      child: Container(
        width: 300.0,
        height: 110.0,
        // color: Colors.blue,
        // margin: const EdgeInsets.symmetric(
        //         horizontal: 0, vertical: 0
        //       ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(
              children: [ 
                Image.asset('icontaps/calendar.png',
              width: 35,
              ),
              Text (' วันเกิด : ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
            Text (birth,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),
            // ),
            Row(
              children: [
                Image.asset('icontaps/heart.png',
              width: 35,
              ),
              Text (' เพศ : ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text (gender,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),
            Row(
              children: [
                Image.asset('icontaps/address.png',
              width: 35,
              ), 
              Text (' ที่อยู่ : ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text (address,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
           // ),
          ],
            ),
          ],
      ),
      ),
    );
  }

    Expanded dataDetailTwo(String email, String line) {
    return Expanded(
      
      child: Container(
        width: 300.0,
        height: 80.0,
        // color: Colors.blue,
        // margin: const EdgeInsets.symmetric(
        //         horizontal: 5, vertical: 5
        //       ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           // Center(
              //child: 
            Row(
              children: [ 
                Image.asset('icontaps/mail.png',
              width: 35,
              ),
              Text (' E-mail : ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
            Text (email,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),
            // ),
            Row(
              children: [
                Image.asset('icontaps/massage.png',
              width: 35,
              ),
              Text (' Line ID : ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text (line,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
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
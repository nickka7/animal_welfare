// import 'dart:html';

import 'package:animal_welfare/screens/profile/colleague_breeder.dart';
import 'package:animal_welfare/screens/profile/colleague_caretaker.dart';
import 'package:animal_welfare/screens/profile/colleague_researcher.dart';
import 'package:animal_welfare/screens/profile/colleague_showman.dart';
import 'package:animal_welfare/screens/profile/colleague_vet.dart';
import 'package:animal_welfare/screens/profile/profile_modifycontact.dart';
import 'package:animal_welfare/screens/profile/profile_modifyname.dart';
import 'package:animal_welfare/screens/profile/profile_modifypicture.dart';
import 'package:animal_welfare/screens/profile/profile_modifyself.dart';
import 'package:flutter/material.dart';
import 'package:animal_welfare/haxColor.dart';


class MyMainProfile extends StatefulWidget {
  const MyMainProfile({ Key? key }) : super(key: key);

  @override
  _MyMainProfileState createState() => _MyMainProfileState();
}

class _MyMainProfileState extends State<MyMainProfile> {
  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
        color: HexColor("#697825")
        ),
        ),
          centerTitle: true,
          title: Text('ข้อมูลส่วนตัว',
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
            Center(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
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
                  ),
                  Align(
                    alignment: Alignment(0.3,0),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                            context,MaterialPageRoute(
                              builder: (context) => const ModifyMyPicture()),
                              ),
                            },
                        child:  Image.asset('icontaps/camera.png',
                        ),
                      ),
                  )
                ],
              ),
                            //  ),                               
            ),
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
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () => {
                          Navigator.push(
                            context,MaterialPageRoute(
                              builder: (context) => const ModifyMyName()),
                              ),
                            },
                        child:  Image.asset('icontaps/pencil.png',
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
              child: Text('ZOO ID',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                ),
                ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              height: 330,
              decoration: BoxDecoration(
                border: Border.all(color: HexColor("#697825")),
                color: HexColor("#ECEFF0"),
              borderRadius: BorderRadius.circular(5.0)),
              
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('ข้อมูลพนักงาน',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () => {
                            Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context) => const ModifyMySelf()),
                              ),
                          },
                          child:  Image.asset('icontaps/pencil.png',
                          ),
                          )],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('ข้อมูลการติดต่อ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () => {
                            Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context) => const ModifyMyContact()),
                              ),
                          },
                          child:  Image.asset('icontaps/pencil.png',
                          ),
                          )],
                      ),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            dataDetailTwo('email', 'line id'),
                            ],
                            )
                        ),
                ],),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Text('เพื่อนร่วมงาน',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),),
              ),
            ),

            Container(
              decoration: BoxDecoration(
              border: Border.all(color: HexColor("#FFFFFF")),
              color: HexColor("#697825"),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,)]
                ),
                height: 45,
                width: double.infinity,
                child:
                // ignore: missing_required_param
                // ignore: deprecated_member_use
                FlatButton(
                  // textColor: Colors.black,
                  child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('ผู้ดูแลสัตว์',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30.0)
                    )],
                ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
                            );
                              
                    //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    //     builder: (BuildContext context) => CountryScreens());
                    // Navigator.of(context).push(materialPageRoute);
                          },
                        ),
                     ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
              border: Border.all(color: HexColor("#FFFFFF")),
              color: HexColor("#697825"),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,)]
                ),
                height: 45,
                width: double.infinity,
                child:
                // ignore: missing_required_param
                // ignore: deprecated_member_use
                FlatButton(
                  // textColor: Colors.black,
                  child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('สัตวแพทย์',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30.0)
                    )],
                ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CollVet())
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => CountryScreens(getData: dataWorld[i], )));
                              
                    //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    //     builder: (BuildContext context) => CountryScreens());
                    // Navigator.of(context).push(materialPageRoute);
                          },
                        ),
                     ),
            Container(
              decoration: BoxDecoration(
              border: Border.all(color: HexColor("#FFFFFF")),
              color: HexColor("#697825"),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,)]
                ),
                height: 45,
                width: double.infinity,
                child:
                // ignore: missing_required_param
                // ignore: deprecated_member_use
                FlatButton(
                  // textColor: Colors.black,
                  child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('นักวิจัย',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30.0)
                    )],
                ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CollResearcher())
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => CountryScreens(getData: dataWorld[i], )));
                              
                    //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    //     builder: (BuildContext context) => CountryScreens());
                    // Navigator.of(context).push(materialPageRoute);
                          },
                        ),
                     ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
              border: Border.all(color: HexColor("#FFFFFF")),
              color: HexColor("#697825"),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,)]
                ),
                height: 45,
                width: double.infinity,
                child:
                // ignore: missing_required_param
                // ignore: deprecated_member_use
                FlatButton(
                  // textColor: Colors.black,
                  child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('นักเพาะพันธุ์',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30.0)
                    )],
                ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CollBreeder())
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => CountryScreens(getData: dataWorld[i], )));
                              
                    //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    //     builder: (BuildContext context) => CountryScreens());
                    // Navigator.of(context).push(materialPageRoute);
                          },
                        ),
                     ),
            Container(
              decoration: BoxDecoration(
              border: Border.all(color: HexColor("#FFFFFF")),
              color: HexColor("#697825"),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,)]
                ),
                height: 45,
                width: double.infinity,
                child:
                // ignore: missing_required_param
                // ignore: deprecated_member_use
                FlatButton(
                  // textColor: Colors.black,
                  child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('ผู้ดูแลการแสดง',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30.0)
                    )],
                ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CollShowman())
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => CountryScreens(getData: dataWorld[i], )));
                              
                    //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    //     builder: (BuildContext context) => CountryScreens());
                    // Navigator.of(context).push(materialPageRoute);
                          },
                        ),
                     )
      
          ]),
        ),
      ),
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
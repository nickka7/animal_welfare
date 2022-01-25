import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/setting/aboutapp_condition.dart';
import 'package:animal_welfare/screens/setting/aboutapp_privacy.dart';
import 'package:flutter/material.dart';

class AboutMyApp extends StatefulWidget {
  const AboutMyApp({Key? key}) : super(key: key);

  @override
  _AboutMyAppState createState() => _AboutMyAppState();
}

class _AboutMyAppState extends State<AboutMyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: HexColor("#697825")),
        ),
        centerTitle: true,
        title:
            Text('เกี่ยวกับแอพ', style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เวอร์ชันที่ใช้อยู่',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'เวอร์ชัน',
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: HexColor("#C4C4C4"),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 1,
              // color: HexColor("#C4C4C4"),
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'เงื่อนไขการเข้าใช้งาน',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,
                          color: Colors.black, size: 25.0)),
                ],
              ),
            ),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ConditionOfUs()))
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              thickness: 1,
              color: HexColor("#C4C4C4"),
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'นโยบายความเป็นส่วนตัว',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,
                          color: Colors.black, size: 25.0)),
                ],
              ),
            ),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()))
            },
          ),
          Divider(
            thickness: 3,
            color: HexColor("#C4C4C4"),
          ),
        ],
      ),
    );
  }
}

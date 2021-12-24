import 'dart:convert';

import 'package:animal_welfare/model/login.dart';
import 'package:flutter/material.dart';
import '../../haxColor.dart';
import '../../navigatorBar.dart';
import 'package:http/http.dart' as http;

class MyLoginHome extends StatefulWidget {
  const MyLoginHome({Key? key}) : super(key: key);

  @override
  _MyLoginHomeState createState() => _MyLoginHomeState();
}

class _MyLoginHomeState extends State<MyLoginHome> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[HexColor("#697825"), HexColor("#FFFFFF")]),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            margin: EdgeInsets.all(30),
                            width: 200.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black45,
                            )),
                      ),
                      //TextForm username
                      TextFormField(
                        controller: userIDController,
                        validator: (String? input) {
                          if (input!.isEmpty) {
                            return "กรุณากรอก username";
                          }
                          return null;
                        },
                        obscureText: true,
                      
                        decoration: InputDecoration(hintText: 'Username'),
                      ),

                      //TextForm password
                      TextFormField(
                        controller: passwordController,
                        validator: (String? input) {
                          if (input!.isEmpty) {
                            return "กรุณากรอก password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          child: Text('ลืมรหัสผ่าน',
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500)),
                          onPressed: () => {
                            /* Navigator.push(
                                context,MaterialPageRoute(
                                  builder: (context) => const SelectMyContact()),
                                  ),*/
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //ปุ่มเข้าสู่ระบบ
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      primary: HexColor('#697825')),
                  child: Text('เข้าสู่ระบบ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                  onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {
                        print(userIDController.text),
                        print(passwordController.text),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavigatorBar()),
                        ),
                      }
                  },
                ),
              ),
              Center(
                child: Text('หากคุณยังไม่มีบัญชีกรุณาลงทะเบียน',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300)),
              ),
              //ปุ่มลงทะเบียน
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      primary: HexColor('#697825')),
                  child: Text('ลงทะเบียน',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                  onPressed: () => {
                    /* Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context) => const MyRegisterHome()),
                                ),*/
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

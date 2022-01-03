import 'dart:convert';

import 'package:flutter/material.dart';
import '../../haxColor.dart';
import '../../navigatorBar.dart';
import 'package:animal_welfare/api/loginApi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyLoginHome extends StatefulWidget {
  const MyLoginHome({Key? key}) : super(key: key);

  @override
  _MyLoginHomeState createState() => _MyLoginHomeState();
}

class _MyLoginHomeState extends State<MyLoginHome> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userIDController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  LoginApi loginAPI = LoginApi();

  final storage = new FlutterSecureStorage();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future doLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        var response = await loginAPI.doLogin(
            _userIDController.text, _passwordController.text);
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print(jsonResponse);
          if (jsonResponse['message'] == 'Login Success') {
            String token = jsonResponse['token'];
            print(token);
            String firstName = jsonResponse['user']['firstName'];
            // print(firstName.runtimeType);
            await storage.write(key: 'token', value: token);
            Navigator.push( //ตอนใช้งานจริงเปลี่ยนไปใช้ Navigator.pushReplacement ตอนนี้ใช้ push เพื่อง่ายต่อการเทส
              context,
              MaterialPageRoute(
                builder: (context) => NavigatorBar(firstName: firstName,),
              ),
            );
          } else {
            displayDialog(context, "An Error Occurred",
                "username หรือ password ไม่ถูกต้อง");
          }
        } else {
          print('Server error');
        }
      } catch (error) {
        print(error);
      }
    }
  }

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
                        controller: _userIDController,
                        validator: (String? input) {
                          if (input!.isEmpty) {
                            return "กรุณากรอก username";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: 'Username'),
                      ),

                      //TextForm password
                      TextFormField(
                        controller: _passwordController,
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
                  onPressed: () => doLogin(),
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

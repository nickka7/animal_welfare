
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/login/reset_newpassword.dart';
import 'package:flutter/material.dart';

class CompleteMyPassword extends StatefulWidget {
  const CompleteMyPassword({ Key? key }) : super(key: key);

  @override
  _CompleteMyPasswordState createState() => _CompleteMyPasswordState();
}

class _CompleteMyPasswordState extends State<CompleteMyPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[HexColor("#697825"), HexColor("#FFFFFF")]
              ),),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 60,horizontal: 30),
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
                                                                //  image: DecorationImage(
                                              // fit: BoxFit.fill,
                              color: Colors.black45,
                                //image: NetworkImage('${dataWorld[i].countryInfo.flag}')
                            )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          child: Text('กรอกรหัสที่คุณได้รับ เพื่อรีเซ็ตรหัสผ่าน',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password'
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          // ignore: deprecated_member_use
                          child: TextButton(
                            child: Text('ส่งรหัสอีกครั้ง',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500)),
                            onPressed: () => {
                              // Navigator.push(
                              // context,MaterialPageRoute(
                              //   builder: (context) => const SelectMyContact()),
                              //   ),
      
                            },
                          ),
                        ),
                        Container(
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    width: 100,
                    height: 45,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                      color: HexColor("#697825"),
                      child: Text('ถัดไป',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500)),
                      onPressed: () => {
                        Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context) => const ResetMyNewPasswor()),
                                ),
                      },),
                  ),
                      ],
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class ResetMyNewPasswor extends StatefulWidget {
  const ResetMyNewPasswor({ Key? key }) : super(key: key);

  @override
  _ResetMyNewPassworState createState() => _ResetMyNewPassworState();
}

class _ResetMyNewPassworState extends State<ResetMyNewPasswor> {
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
                          margin: EdgeInsets.only(top: 10,left: 5),
                          child: Text('กรอกรหัสผ่านใหม่ของคุณ',
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
                        Container(
                          margin: EdgeInsets.only(top: 30,left: 5),
                          child: Text('ยืนยันรหัสอีกครั้ง',
                          style: TextStyle(
                            color: HexColor("#1273EB"),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password'
                            ),
                          ),
                        ),
                        Container(
                    margin: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                    width: 90,
                    height: 45,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                      color: HexColor("#697825"),
                      child: Text('บันทึก',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500)),
                      onPressed: () => {
                        // Navigator.push(
                        //       context,MaterialPageRoute(
                        //         builder: (context) => const CompleteMyPassword()),
                        //         ),
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
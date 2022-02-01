import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/login/complete_password.dart';
import 'package:flutter/material.dart';

class SelectMyContact extends StatefulWidget {
  const SelectMyContact({ Key? key }) : super(key: key);

  @override
  _SelectMyContactState createState() => _SelectMyContactState();
}

class _SelectMyContactState extends State<SelectMyContact> {
  // The inital group value
  String _selectedContact = '';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        child: Text('ระบบตรวจสอบข้อมูลเฉพาะตัวของคุณ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('(เลือกช่องทางที่จะส่งรหัสการตรวจสอบ)',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500)
                        ),
                      ),
                      ListTile(
                leading: Radio(
                  value: 'email',
                  groupValue: _selectedContact,
                  onChanged: (value) {
                    setState(() {
                      _selectedContact = 'email';
                    });
                  },
                ),
                title: Text('Email'),
              ),
              ListTile(
                leading: Radio(
                  value: 'เบอร์โทรศัพท์',
                  groupValue: _selectedContact,
                  onChanged: (value) {
                    setState(() {
                      _selectedContact = 'เบอร์โทรศัพท์';
                    });
                  },
                ),
                title: Text('เบอร์โทรศัพท์'),
              ),
               Container(
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  width: 80,
                  height: 45,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                    // padding: EdgeInsets.symmetric(vertical: 5),
                    color: HexColor("#697825"),
                    child: Text('ส่ง',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
                    onPressed: () => {
                      Navigator.push(
                            context,MaterialPageRoute(
                              builder: (context) => const CompleteMyPassword()),
                              ),
                    },),
                ),
                    ],
                  ),
                ),
              ],
            ),
      )
      
    );
  }
}
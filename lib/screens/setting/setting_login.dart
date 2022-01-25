import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/setting/setting_password.dart';
import 'package:flutter/material.dart';

class MyLoginChoice extends StatefulWidget {
  const MyLoginChoice({ Key? key }) : super(key: key);

  @override
  _MyLoginChoiceState createState() => _MyLoginChoiceState();
}

class _MyLoginChoiceState extends State<MyLoginChoice> {

  bool _enableFingerPrint = false;


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
          title: Text('การเข้าสู่ระบบ',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10,right: 20,left: 20),
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: SwitchListTile(
                    title: Text('สแกนลายนิ้วมือ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                      ),
                      value: _enableFingerPrint,
                      onChanged: (bool value) {
                        setState(() {
                          _enableFingerPrint = value;
                          });
                        }),
                  ),
                  Divider(
                    thickness: 1,
                    color: HexColor("#C4C4C4"),
                  ),
              ],
            ),
            
          ),
          
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            // ignore: deprecated_member_use
            child: FlatButton(
                      child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('เปลี่ยนรหัสพิน',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 25.0)
                                )],
                            ),
                              onPressed: () => {
                                Navigator.push(
                                context,MaterialPageRoute(
                                  builder: (context) => const SettingPassword()),
                                ),
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
                                    // );
                                      
                            //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                            //     builder: (BuildContext context) => CountryScreens());
                            // Navigator.of(context).push(materialPageRoute);
                                  },
                    ),
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
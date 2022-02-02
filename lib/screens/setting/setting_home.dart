import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/setting/setting_aboutapp.dart';
import 'package:animal_welfare/screens/setting/setting_login.dart';
import 'package:animal_welfare/screens/setting/setting_logout.dart';
import 'package:animal_welfare/screens/setting/setting_notifications.dart';
import 'package:animal_welfare/screens/setting/setting_question.dart';
import 'package:flutter/material.dart';

class MySettingHome extends StatefulWidget {
  const MySettingHome({ Key? key }) : super(key: key);

  @override
  _MySettingHomeState createState() => _MySettingHomeState();
}

class _MySettingHomeState extends State<MySettingHome> {
  bool tappedYes = false;
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
          title: Text('ตั้งค่า',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10,right: 20,left: 20),
            child: Column(
              children: [
                // ignore: deprecated_member_use
                  FlatButton(
                    child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('การแจ้งเตือน',
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
                                builder: (context) => const NyNotifications()),
                              ),
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
                                  // );
                                    
                          //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          //     builder: (BuildContext context) => CountryScreens());
                          // Navigator.of(context).push(materialPageRoute);
                                },
                  ),
                Divider(
                  thickness: 1,
                  color: HexColor("#C4C4C4"),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('การเข้าสู่ระบบ',
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
                                builder: (context) => const MyLoginChoice()),
                              ),
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
                                  // );
                                    
                          //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          //     builder: (BuildContext context) => CountryScreens());
                          // Navigator.of(context).push(materialPageRoute);
                                },
                  ),
                Divider(
                  thickness: 1,
                  color: HexColor("#C4C4C4"),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('คำถามที่พบบ่อย',
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OurQuestions())
                                  )
                                    
                          //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          //     builder: (BuildContext context) => CountryScreens());
                          // Navigator.of(context).push(materialPageRoute);
                                },
                  ),
                Divider(
                  thickness: 1,
                  color: HexColor("#C4C4C4"),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    child:Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('เกี่ยวกับแอพ',
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutMyApp())
                                  )
                                    
                          //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          //     builder: (BuildContext context) => CountryScreens());
                          // Navigator.of(context).push(materialPageRoute);
                                },
                  ),
                // Divider(
                //   thickness: 1,
                //   color: HexColor("#C4C4C4"),
                //   ),
                  // ignore: deprecated_member_use
                  // FlatButton(
                  //   child: Stack(
                  //           children: [
                  //             Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Text('เงื่อนไขการเข้าใช้งาน',
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 18.0,
                  //                 fontWeight: FontWeight.w500),
                  //               ),
                  //             ),
                  //             Align(
                  //               alignment: Alignment.centerRight,
                  //               child: Icon(Icons.arrow_forward_ios,
                  //               color: Colors.black,
                  //               size: 25.0)
                  //             )],
                  //         ),
                  //           onPressed: (){
                  //                 // Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
                  //                 // );
                                    
                  //         //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  //         //     builder: (BuildContext context) => CountryScreens());
                  //         // Navigator.of(context).push(materialPageRoute);
                  //               },
                  // ),
                Divider(
                  thickness: 1,
                  color: HexColor("#C4C4C4"),
                  ),
                  // ignore: deprecated_member_use
                  
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              // decoration: BoxDecoration(
              //   boxShadow: [BoxShadow(
              //     // color: Colors.black26,
              //     offset: Offset(0.0, 4.0),
              //     blurRadius: 4.0,)]
              //     ),
              // ignore: deprecated_member_use
              child: FlatButton(
                        child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('ออกจากระบบ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 25.0)
                                  )],
                              ),
                                onPressed: () async {
                                  final action = await UserLogout.yesCancelDialog(context, 'ต้องการออกจากระบบ');
                                  if (action == DialogAction.yes) {
                                    setState(() => UserLogout().clearTokenAndLogout(context));
                                    } else {
                                      setState(() => tappedYes = true);
                                    }
                                  },
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => doUserLogout())
                                      // );
                                        
                              //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                              //     builder: (BuildContext context) => CountryScreens());
                              // Navigator.of(context).push(materialPageRoute);
                                    
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


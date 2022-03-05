import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/setting/setting_logout.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
          title: Text('เมนูอื่นๆ',
          style: const TextStyle(color: Colors.white)   
      ),automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
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
                                      // Align(
                                      //   alignment: Alignment.centerRight,
                                      //   child: Icon(Icons.arrow_forward_ios,
                                      //   color: Colors.black,
                                      //   size: 25.0)
                                      // )
                                      ],
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
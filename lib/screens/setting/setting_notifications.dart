import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class NyNotifications extends StatefulWidget {
  const NyNotifications({ Key? key }) : super(key: key);

  @override
  _NyNotificationsState createState() => _NyNotificationsState();
}

class _NyNotificationsState extends State<NyNotifications> {

  bool _enableNotifications = false;



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
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SwitchListTile(
              title: Text('แจ้งเตือน',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
                ),
                value: _enableNotifications,
                onChanged: (bool value) {
                  setState(() {
                    _enableNotifications = value;
                    });
                  }),
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
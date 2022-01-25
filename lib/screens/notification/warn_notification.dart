import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/timecheck/time_check.dart';
import 'package:flutter/material.dart';


class WarnNotifications extends StatefulWidget {
  const WarnNotifications({ Key? key }) : super(key: key);

  @override
  _WarnNotificationsState createState() => _WarnNotificationsState();
}

class _WarnNotificationsState extends State<WarnNotifications> {
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
          title: Text('แจ้งเตือน',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: ListView.builder(
                    itemCount: 3,
                    // snapshot.data?.flights?.length ?? 0
                    itemBuilder: (context, i){
                      return Container(
                        decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#697825")),
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,)]
                        ),
                    
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ignore: deprecated_member_use
                              FlatButton(
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 7
                                      ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                       
                                       Flexible(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            cardDetail('timecheck', 'name','date','time'),
                                            // 'Place Name : ${snapshot.data?.flights?[i].airline ?? 'ไม่พบข้อมูล'}'
                                          ],
                                        )
                                       ), 
                                       
                                          
                                        
                                      ],
                                  ),
                                ),
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkTimeCheck()));
                                  },
                              ),
                            ],
                          ),
                        );
                    },
                  ),
      
    );
  }

  Expanded cardDetail(String timecheck, String name, String date, String time) {
    return Expanded(
      
      child: Container(
        width: 150.0,
        height: 100.0,
        //color: Colors.blue,
        margin: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 5
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

              Row(
                children: [
                  Text (timecheck,
                  style: TextStyle(
                    color: HexColor("#697825"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),  
            ),
            Icon(Icons.timer,
            size: 25,
            color: HexColor("#697825"),)
                ],
              ),
            
            //),
            Row(
              children: [ 
                Text('     คุณ ',
                  style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (name,
              style: TextStyle(
                color: HexColor("#34C1FF"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),
            Row(
              children: [ 
                Text('     วันที่ ',
                  style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (date,
              style: TextStyle(
                color: HexColor("#34C1FF"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
            Text('     เวลา ',
                  style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (time,
              style: TextStyle(
                color: HexColor("#34C1FF"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),

            
          ],
      ),
      ),
    );
  }

}
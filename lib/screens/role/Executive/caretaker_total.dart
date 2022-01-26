import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/Executive/caretakers_profile.dart';

import 'package:flutter/material.dart';

class CaretakerTotal extends StatefulWidget {
  const CaretakerTotal({ Key? key }) : super(key: key);

  @override
  _CaretakerTotalState createState() => _CaretakerTotalState();
}

class _CaretakerTotalState extends State<CaretakerTotal> {
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
          title: Text('จำนวนเจ้าหน้าที่',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
                  // height: 20.0,
                  // color: Colors.blue,
                  //color: Colors.blue,
                  margin: const EdgeInsets.symmetric(
                  horizontal: 15
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('ทั้งหมด คน',
                  style: TextStyle(
                        color: HexColor("#1273EB"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),),
                ],
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i){
                      return Container(
                        decoration: BoxDecoration(
                        color: HexColor("#ECEFF0"),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,)]
                        ),
                    
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7
                        ),
                          child: 
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakesProfile()));
                                    },
                                    child: Container(
                                        // width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 7
                                            ),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                             Flexible(
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  cardDetail('zoo id', 'name'),
                                                ],
                                              )
                                             ),
                                             Container(
                                               color: HexColor("#DADADA"),
                                               height: 110, width: 2,
                                             ),
                                             Flexible(
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  workDetail('วัน', 'วัน', 'วัน', 'วัน'),
                                                ],
                                              )
                                             ),  
                                            ],
                                        ),
                                        
                                      ),
                                        ),
                                  ),
                              //   ],
                              // ),
                          //   ],
                          // ),
                        );
                    },
                  ),
                  flex: 13,
          ),

        ],
      )
    );
  }

  Expanded cardDetail(String zooid, String name) {
    return Expanded(
      
      child: Container(
        width: 300.0,
        height: 100.0,
        //color: Colors.blue,
        margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [ 
                Text('ZOO ID : ',
                  style: TextStyle(
                color: HexColor("#1273EB"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (zooid,
              style: TextStyle(
                color: HexColor("#1273EB"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),
            Text (name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),  
            ),

            
          ],
      ),
      ),
    );
  }
  
    Expanded workDetail(String work, String sick, String leave, String absent) {
    return Expanded(
      
      child: Container(
        width: 10.0,
        height: 100.0,
        //color: Colors.blue,
        margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                Text('ทำงาน ',
                  style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (work,
              style: TextStyle(
                color: HexColor("#28B446"),
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),  
            ),
            
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                Text('ลาป่วย ',
                  style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (sick,
              style: TextStyle(
                color: HexColor("#4DB6AC"),
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),  
            ),
            
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                Text('ลากิจ ',
                  style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (leave,
              style: TextStyle(
                color: HexColor("#DD873C"),
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),  
            ),
            
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                Text('ขาดงาน ',
                  style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (absent,
              style: TextStyle(
                color: HexColor("#F14336"),
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
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
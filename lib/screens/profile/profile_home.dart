import 'package:flutter/material.dart';
import 'package:animal_welfare/haxColor.dart';

class MyHomeProfile extends StatefulWidget {
  const MyHomeProfile({Key? key}) : super(key: key);

  @override
  _MyHomeProfileState createState() => _MyHomeProfileState();
}

class _MyHomeProfileState extends State<MyHomeProfile> {
  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                Colors.lightBlue.shade100,
                Colors.blue.shade600
              ]))),
          centerTitle: true,
          title: Text('ข้อมูลส่วนตัว'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          color: Colors.green.shade100,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 140,
                            color: Colors.blue.shade100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fname',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '  Lname',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'ตำแหน่ง',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'ZOO ID : 1234567',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: HexColor("#E0D892"),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      'แก้ไขข้อมูลส่วนตัว  >',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          // ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        width: 120.0,
                        height: 120.0,
                        // color: Colors.grey
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey
                            //  image: DecorationImage(
                            // fit: BoxFit.fill,
                            //  )
                            )),
                  )
                ],
              ),
              Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
              ),
          
              margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 7
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Text('ตำแหน่ง',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                  ),)

                             )
                             
                          ]
                          ),
                      
                    )
                  
              
              
            ],
          ),
        ));
  }
}

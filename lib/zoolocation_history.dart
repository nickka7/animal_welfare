import 'dart:convert';

import 'package:animal_welfare/model/getLocation.dart';
import 'package:animal_welfare/model/history_booking.dart';

// import 'package:animal_welfare/screens/role/admin/addlocation_zoo.dart';
// import 'package:animal_welfare/screens/role/admin/repair_zoolocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import '../../../constant.dart';
import '../../../haxColor.dart';

class ZooLocationHistory extends StatefulWidget {
  const ZooLocationHistory({Key? key}) : super(key: key);

  @override
  State<ZooLocationHistory> createState() => _ZooLocationHistoryState();
}

class _ZooLocationHistoryState extends State<ZooLocationHistory> {
  final storage = new FlutterSecureStorage();

  // Future<HistoryBooking> getStorybooking() async {
  //   String? token = await storage.read(key: 'token');
  //   String endPoint = Constant().endPoint;
  //   var response = await http.get(Uri.parse('$endPoint/api/historyBookingRoom'),
  //       headers: {"authorization": 'Bearer $token'});

  //   print(response.body);
  //   var jsonData = HistoryBooking.fromJson(jsonDecode(response.body));
  //   print(jsonData);
  //   return jsonData;
  // }

  Future<GetLocation> getHistoryDoor() async {
    // String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response =
        await http.get(Uri.parse('$endPoint/api/getLocation'), headers: {
      "authorization":
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJaMDAwMDAiLCJyb2xlSUQiOiJaMDAiLCJyb2xlIjoiYWRtaW4iLCJmaXJzdE5hbWUiOiLguJXguLDguKfguLHguJkiLCJsYXN0TmFtZSI6IuC4i-C4seC4meC4iuC4suC4oiIsImltYWdlIjoiMjA3ZTY5NjctYjkzNC00Y2YxLTlkMWQtOTRjMjk2YTY5NTI5MjA4MDYyMDgyNTk3MDYzMzQ0NS5qcGciLCJpYXQiOjE2NTE0Njg0NzUsImV4cCI6MTY1MTY0MTI3NX0.a3FM73P9DzUliSS0amu-STQvn-I-XZ_XE1y7Mw9w8ik'
    });
    // print("1234${response.body}");
    // var z = jsonDecode(response.body);
    // print(z.runtimeType);
    // print(z);
    // print(z['message'][0]['door']);

    try {
      var jsonData = GetLocation.fromJson(jsonDecode(response.body));
      // print(jsonData);
      // print("1255");
    } catch (e) {
      print(e);
    }
    var jsonData = GetLocation.fromJson(jsonDecode(response.body));

    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F7F7F7"),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: HexColor("#697825")),
          ),
          centerTitle: true,
          title: Text('เพิ่มตำแหน่งสวนสัตว์',
              style: const TextStyle(color: Colors.white)),
        ),
        body: FutureBuilder(
          future: getHistoryDoor(),
          builder: (BuildContext context, AsyncSnapshot<GetLocation> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              CircularProgressIndicator();
              print('circle waiting');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              // print(snapshot.data.);

              // print('${snapshot.data?.message?[0].latitude}');

              return Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'ตำแหน่งสวนสัตว์ทั้งหมด',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.message?.length,
                        // snapshot.data!.data!.length
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 110,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: HexColor('#697825'), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "ประตู : ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "${snapshot.data?.message?[index].door}",
                                            style: TextStyle(
                                                color: HexColor("#34C1FF"),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),

                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      //   children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Latitude (ละติจูด) : ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "${snapshot.data?.message?[index].latitude}",
                                            style: TextStyle(
                                                color: HexColor("#34C1FF"),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      //   Text(
                                      // "Latitude",
                                      // style: TextStyle(
                                      //   color: HexColor("#34C1FF"),
                                      //   fontSize: 20,
                                      //   fontWeight: FontWeight.w600),
                                      //   ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),

                                      Row(
                                        children: [
                                          Text(
                                            "Longitude (ลองจิจูด) : ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "${snapshot.data?.message?[index].longitude}",
                                            style: TextStyle(
                                                color: HexColor("#34C1FF"),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),

                                      // Container(
                                      //   child: Row(
                                      //     children: [
                                      //       Flexible(
                                      //         child: Text(
                                      //           "อาคาร : ",
                                      //           overflow:
                                      //               TextOverflow.ellipsis,
                                      //           style: TextStyle(
                                      //             fontSize: 16,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // Container(
                                      //   child: Row(
                                      //     children: [
                                      //       Flexible(
                                      //         child: Text(
                                      //           "ห้อง : ",
                                      //           // ${snapshot.data!.data![index].requestMessage}
                                      //           overflow:
                                      //               TextOverflow.ellipsis,
                                      //           style: TextStyle(
                                      //             fontSize: 16,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      //                     ]
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //เลื่อนเพื่อแก้ไข ลบ ข้อมูล
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'แก้ไข',
                                color: Colors.green,
                                icon: Icons.build_rounded,
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => RepairZooLocation(
                                  //             door:
                                  //                 '${snapshot.data!.message![index].door}',
                                  //             lat:
                                  //                 '${snapshot.data!.message![index].latitude}',
                                  //             long:
                                  //                 '${snapshot.data!.message![index].longitude}',
                                  //           )),
                                  // ).then((value) =>
                                  //     setState(() {})); //หลังจาก call back เรียก setState
                                },
                              ),
                              IconSlideAction(
                                caption: 'ลบ',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  // deleteMaintenance(
                                  //         '${snapshot.data!.data![index].maintenanceID}')
                                  //     .then(
                                  //         (value) => snapshot.data!.data!.removeAt(index))
                                  //     .then((value) => setState(() {}))
                                  //     .then((value) => ScaffoldMessenger.of(context)
                                  //         .showSnackBar(snackBar));
                                },
                              ),
                              IconSlideAction(
                                caption: 'ปิด',
                                color: Colors.grey,
                                icon: Icons.close,
                                onTap: () {},
                              ),
                            ],
                            //   ),
                            // ),
                          );
                        }),
                    flex: 15,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: HexColor("#C4C4C4"),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,
                        )
                      ]),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        // textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: HexColor("#697825"),
                        child: Text('เพิ่มตำแหน่งสวนสัตว์',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            )),
                        onPressed: () => {
                          // Navigator.push(
                          // context,MaterialPageRoute(
                          //   builder: (context) => const AddLocationZoo()),
                          // ),
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
                          // );

                          //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          //     builder: (BuildContext context) => CountryScreens());
                          // Navigator.of(context).push(materialPageRoute);
                        },
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              );
            } else {
              return Text('ไม่สามารถโหลดข้อมูลได้');
            }
          },
        ));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor("#F7F7F7"),
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//         color: HexColor("#697825")
//         ),
//         ),
//           centerTitle: true,
//           title: Text('เพิ่มตำแหน่งสวนสัตว์',
//           style: const TextStyle(color: Colors.white)
//       ),
//       ),
//       body: FutureBuilder(
//           builder: (BuildContext context, AsyncSnapshot<GetLocation> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               CircularProgressIndicator();
//               print ('circle waiting');
//             }
//             if (snapshot.connectionState == ConnectionState.done) {
//               print ('Done');

//               return
//       Column(
//         children: [
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('ตำแหน่งสวนสัตว์ทั้งหมด',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.w700),
//                       ),
//                 ],
//               ),
//               ),
//               flex: 2,
//           ),
//           Expanded(
//             child: ListView.builder(
//                     itemCount: snapshot.data?.message?.length,
//                     // snapshot.data!.data!.length
//                     itemBuilder: (context, index) {
//                       return Slidable(
//                         actionPane: SlidableDrawerActionPane(),
//                         actionExtentRatio: 0.25,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 110,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border:
//                                   Border.all(color: HexColor('#697825'), width: 1),
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 15),
//                               child:
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                             "ประตู : ",
//                                             style: TextStyle(
//                                               fontSize: 18),
//                                               ),
//                                       Text(
//                                         "${snapshot.data?.message?[index].door}",
//                                         style: TextStyle(
//                                           color: HexColor("#34C1FF"),
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w600),
//                                           ),
//                                     ],
//                                   ),

//                                   // Row(
//                                   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   //   children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             "Latitude (ละติจูด) : ",
//                                             style: TextStyle(
//                                               fontSize: 18),
//                                               ),
//                                           Text(
//                                         "${snapshot.data?.message?[index].latitude}",
//                                         style: TextStyle(
//                                           color: HexColor("#34C1FF"),
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w600),
//                                           ),
//                                         ],
//                                       ),
//                                         //   Text(
//                                         // "Latitude",
//                                         // style: TextStyle(
//                                         //   color: HexColor("#34C1FF"),
//                                         //   fontSize: 20,
//                                         //   fontWeight: FontWeight.w600),
//                                         //   ),
//                                       // SizedBox(
//                                       //   width: 10,
//                                       // ),

//                                       Row(
//                                         children: [
//                                           Text(
//                                             "Longitude (ลองจิจูด) : ",
//                                             style: TextStyle(
//                                               fontSize: 18),
//                                               ),
//                                           Text(
//                                         "${snapshot.data?.message?[index].longitude}",
//                                         style: TextStyle(
//                                           color: HexColor("#34C1FF"),
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w600),
//                                           ),
//                                         ],
//                                       ),

//                                                   // Container(
//                                                   //   child: Row(
//                                                   //     children: [
//                                                   //       Flexible(
//                                                   //         child: Text(
//                                                   //           "อาคาร : ",
//                                                   //           overflow:
//                                                   //               TextOverflow.ellipsis,
//                                                   //           style: TextStyle(
//                                                   //             fontSize: 16,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //     ],
//                                                   //   ),
//                                                   // ),
//                                                   // Container(
//                                                   //   child: Row(
//                                                   //     children: [
//                                                   //       Flexible(
//                                                   //         child: Text(
//                                                   //           "ห้อง : ",
//                                                   //           // ${snapshot.data!.data![index].requestMessage}
//                                                   //           overflow:
//                                                   //               TextOverflow.ellipsis,
//                                                   //           style: TextStyle(
//                                                   //             fontSize: 16,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //     ],
//                                                   //   ),
//                                                   // ),
//                             //                     ]
//                             // ),
//                                 ],
//                               ),
//                         ),
//                           ),
//                         ),

//                         //เลื่อนเพื่อแก้ไข ลบ ข้อมูล
//                         secondaryActions: <Widget>[
//                           IconSlideAction(
//                             caption: 'แก้ไข',
//                             color: Colors.green,
//                             icon: Icons.build_rounded,
//                             onTap: () {
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //       builder: (context) => RepairNoticeUpdate(
//                               //             maintenanceID:
//                               //                 '${snapshot.data!.data![index].maintenanceID}',
//                               //             location:
//                               //                 '${snapshot.data!.data![index].location}',
//                               //             maintenanceDetail:
//                               //                 '${snapshot.data!.data![index].requestMessage}',
//                               //           )),
//                               // ).then((value) =>
//                               //     setState(() {})); //หลังจาก call back เรียก setState
//                             },
//                           ),
//                           IconSlideAction(
//                             caption: 'ลบ',
//                             color: Colors.red,
//                             icon: Icons.delete,
//                             onTap: () {
//                               // deleteMaintenance(
//                               //         '${snapshot.data!.data![index].maintenanceID}')
//                               //     .then(
//                               //         (value) => snapshot.data!.data!.removeAt(index))
//                               //     .then((value) => setState(() {}))
//                               //     .then((value) => ScaffoldMessenger.of(context)
//                               //         .showSnackBar(snackBar));
//                             },
//                           ),
//                           IconSlideAction(
//                             caption: 'ปิด',
//                             color: Colors.grey,
//                             icon: Icons.close,
//                             onTap: () {},
//                           ),
//                         ],
//                         //   ),
//                         // ),
//                       );
//                     }),
//                     flex: 15,
//           ),
//           Expanded(
//               child: Divider(
//                 thickness: 1,
//                 color: HexColor("#C4C4C4"),
//               ),
//               flex: 1,
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(left: 10,right: 10,bottom: 15),
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     boxShadow: [BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0.0, 4.0),
//                       blurRadius: 4.0,)]
//                       ),
//                       // ignore: deprecated_member_use
//                       child: FlatButton(
//                         // textColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0)),
//                           color: HexColor("#697825"),
//                           child: Text('เพิ่มตำแหน่งสวนสัตว์',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.w500,
//                             )
//                             ),
//                             onPressed: () => {
//                               Navigator.push(
//                               context,MaterialPageRoute(
//                                 builder: (context) => const AddLocationZoo()),
//                               ),
//                                   // Navigator.push(context, MaterialPageRoute(builder: (context) => CollCaretaker())
//                                   // );

//                           //          MaterialPageRoute materialPageRoute = MaterialPageRoute(
//                           //     builder: (BuildContext context) => CountryScreens());
//                           // Navigator.of(context).push(materialPageRoute);
//                                 },
//                         ),
//                   ),
//                   flex: 2,
//             ),
//         ],
//       );
//       } else {
//               return Text('ไม่สามารถโหลดข้อมูลได้');
//             }
//           },
//           future: getHistoryDoor(),
//       )
//     );
//   }

// }

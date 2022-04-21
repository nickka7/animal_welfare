import 'dart:convert';
import 'package:animal_welfare/screens/role/Executive/allshow.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:animal_welfare/screens/SearchAllAnimal.dart';
import 'package:animal_welfare/screens/role/Executive/animalReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class CeoHome extends StatefulWidget {
  const CeoHome({
    Key? key,
  }) : super(key: key);

  @override
  _CeoHomeState createState() => _CeoHomeState();
}

class _CeoHomeState extends State<CeoHome> {
  // DateTime myDateTime = DateTime.now();

  @override
  void initState() {
    getAnimal();
    super.initState();
  }

  final storage = new FlutterSecureStorage();

  Future<AllAnimals> getAnimal() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getAnimalInZoo'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = AllAnimals.fromJson(jsonDecode(response.body));
    print('$jsonData');
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'งาน',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<AllAnimals>(
          future: getAnimal(),
          builder: (BuildContext context, AsyncSnapshot<AllAnimals> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: [
                    //  Padding(
                    //         padding: const EdgeInsets.only(top: 15, left: 8),
                    //         child: Align(
                    //             alignment: Alignment.topLeft,
                    //             child: _heading('สัตว์ทั้งหมด', 35.0, 120.0)),
                    //       ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Card(
                        elevation: 5,
                        // ignore: deprecated_member_use
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchAllAnimal()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'จำนวนสัตว์ทั้งหมด ${snapshot.data?.data?.amount} ตัว',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.black,
                                    size: 40,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Card(
                       // color: HexColor('#697825'),
                        elevation: 5,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimalReportTest()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('รายงานการฉีดวัคซีนของสัตว์แต่ละชนิด',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.black,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Card(
                       // color: HexColor('#697825'),
                        elevation: 5,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllShow()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('รอบการแสดง',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.black,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget _heading(var title, double h, double w) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          color: HexColor("#697825"),
          borderRadius: BorderRadius.all(Radius.circular(45))),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

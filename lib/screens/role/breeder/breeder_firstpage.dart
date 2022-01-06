import 'dart:convert';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:animal_welfare/screens/SearchAllAnimal.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/haxColor.dart';

import 'package:animal_welfare/screens/role/breeder/breeder_searchHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class BreederFirstpage extends StatefulWidget {
  const BreederFirstpage({Key? key}) : super(key: key);

  @override
  _BreederFirstpageState createState() => _BreederFirstpageState();
}

class _BreederFirstpageState extends State<BreederFirstpage> {
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

  DateTime date = DateTime.now();
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
        body: Container(
            color: HexColor('#697825'),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            'วันที่',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          '${DateFormat("d", 'th').format(date)}',
                          style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '${DateFormat("MMMM yyyy", 'th').format(date)}',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#F2F2F2"),
                      borderRadius:
                          BorderRadius.only(topRight: (Radius.circular(60))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 25),
                      child: totalAnimal(),
                    ),
                  ),
                )
              ],
            )));
  }

  Widget totalAnimal() {
    return FutureBuilder<AllAnimals>(
      future: getAnimal(),
      builder: (BuildContext context, AsyncSnapshot<AllAnimals> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 8),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: _heading('สัตว์ทั้งหมด', 35.0, 120.0)),
                  ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  breederData(),
                ],
              ),
            ),
          );
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget breederData() {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 8),
          child: Align(
              alignment: Alignment.topLeft,
              child: _heading('ข้อมูลการเพาะพันธุ์', 35.0, 170.0)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Card(
            elevation: 5,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BreederSearchHistory()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ข้อมูลการเพาะพันธุ์สัตว์แต่ละชนิด',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
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

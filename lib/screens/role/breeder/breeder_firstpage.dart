import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/allanimal.dart';
import 'package:animal_welfare/screens/FilterAllAnimal.dart';
import 'package:animal_welfare/screens/role/breeder/breeder_searchHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../constant.dart';

class BreederFirstpage extends StatefulWidget {
  const BreederFirstpage({Key? key}) : super(key: key);

  @override
  _BreederFirstpageState createState() => _BreederFirstpageState();
}

class _BreederFirstpageState extends State<BreederFirstpage> {
  final storage = new FlutterSecureStorage();

  Future<Allanimals> getAnimal() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getAnimalInZoo'),
        headers: {"authorization": 'Bearer $token'});
    // print(response.body);
    var jsonData = Allanimals.fromJson(jsonDecode(response.body));
    // print(jsonData);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'นักเพาะพันธุ์',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: HexColor('#F2F2F2'),
        child: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder<Allanimals>(
              future: getAnimal(),
              builder: (BuildContext context,
                  AsyncSnapshot<Allanimals> snapshot) {
                if (snapshot.hasError) print('${snapshot.error}');
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 8),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('สัตว์ทั้งหมด',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            elevation: 5,
                            // ignore: deprecated_member_use
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FilterAnimalData()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'จำนวนสัตว์ทั้งหมด : ${snapshot.data!.data!.amount} ตัว',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
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
                      ],
                    ),
                  );
                }
                else {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
              },
            ),
          ]

              // totalAnimal(), breederData()],
              ),
        ),
      ),
    );
  }

  Widget totalAnimal() {
    return FutureBuilder<Allanimals>(
      future: getAnimal(),
      builder: (BuildContext context, AsyncSnapshot<Allanimals> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('สัตว์ทั้งหมด',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 5,
                    // ignore: deprecated_member_use
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterAnimalData()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'จำนวนสัตว์ทั้งหมด : ${snapshot.data!.data!.amount} ตัว',
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
              ],
            ),
          );
        }
        return Text('');
      },
    );
  }

  Widget breederData() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BreederSearchHistory()),
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
    ));
  }
}

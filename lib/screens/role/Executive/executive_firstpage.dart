import 'dart:convert';
import 'package:animal_welfare/screens/role/Executive/allshow.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:animal_welfare/screens/SearchAllAnimal.dart';
import 'package:animal_welfare/screens/role/Executive/animalReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
                    title('จำนวนสัตว์ทั้งหมด ${snapshot.data?.data?.amount} ตัว', SearchAllAnimal()),
                    title('รายงานการฉีดวัคซีนสัตว์แต่ละชนิด',AnimalReportTest()),
                    title('รอบการแสดง', AllShow())
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

//ขนาด สี ตัวอักษร
  Widget title(String text, var page) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Card(
            elevation: 5,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text,
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
}

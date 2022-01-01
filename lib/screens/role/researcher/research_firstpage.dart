import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';

// import 'package:animal_welfare/model/allanimal.dart';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:animal_welfare/screens/allAnimalInZoo.dart';
import 'package:animal_welfare/screens/role/researcher/research_searchHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../allAnimalInZoo.dart';

class ResearcherFirstpage extends StatefulWidget {
  const ResearcherFirstpage({Key? key}) : super(key: key);

  @override
  _ResearcherFirstpageState createState() => _ResearcherFirstpageState();
}

class _ResearcherFirstpageState extends State<ResearcherFirstpage> {
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
          'นักวิจัย',
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
          child: Column(
            children: [totalAnimal(), researchData()],
          ),
        ),
      ),
    );
  }

  Widget totalAnimal() {
    return FutureBuilder<AllAnimals>(
      future: getAnimal(),
      builder: (BuildContext context, AsyncSnapshot<AllAnimals> snapshot) {
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
                                builder: (context) => SearchAllAnimal()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${snapshot.data?.data?.amount} ตัว' ,
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
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget researchData() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResearchHistory()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ข้อมูลงานวิจัยสัตว์แต่ละชนิด',
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

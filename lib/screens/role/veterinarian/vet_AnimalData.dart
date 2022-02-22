import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/MedHis.dart';
import 'package:animal_welfare/model/VacHis.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_MedicalHistory.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_VaccineHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VetAnimalData extends StatefulWidget {
  final Bio getanimal;
  final String? animalID;
  const VetAnimalData({Key? key, required this.getanimal, this.animalID}) : super(key: key);

  @override
  _VetAnimalDataState createState() => _VetAnimalDataState();
}

class _VetAnimalDataState extends State<VetAnimalData> {
  final storage = new FlutterSecureStorage();

  Future<MedHis> getMedHis() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(
        Uri.parse(
            '$endPoint/api/getMedicalHistory?animalID=${widget.animalID}'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = MedHis.fromJson(jsonDecode(response.body));
    print('$jsonData');
    return jsonData;
  }

  Future<VacHis> getVacHis() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(
        Uri.parse(
            '$endPoint/api/getVaccineHistory?animalID=${widget.animalID}'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = VacHis.fromJson(jsonDecode(response.body));
    print('$jsonData');
    return jsonData;
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#697825"),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ข้อมูลสัตว์',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          Stack(children: [
            picture(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 210, bottom: 8, left: 10, right: 10),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: information(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: medicalHistory(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: vaccineHistory(),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  //รูปและชื่อสัตว์
  Widget picture() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#E5E5E5"),
        borderRadius: BorderRadius.only(
            bottomLeft: (Radius.circular(45)),
            bottomRight: (Radius.circular(45))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                '${widget.getanimal.image}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.getanimal.animalName}',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  //ข้อมูลสัตว์แต่ละตัว
  Widget information() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: _heading('ข้อมูล', 35.0, 80.0)),
              ),
              SizedBox(
                height: 10,
              ),
              _buildfont('ANIMAL ID : ', '${widget.getanimal.animalID}'),
              _buildfont('ชนิด : ', '${widget.getanimal.typeName}'),
              _buildfont('รหัสกรง : ', '${widget.getanimal.age}'),
              _buildfont('เพศ : ', '${widget.getanimal.gender}'),
              _buildfont('อายุ : ', '${widget.getanimal.age} ปี'),
              _buildfont('น้ำหนัก : ', '${widget.getanimal.weight} กิโลกรัม'),
              _buildfont('กรง : ', '${widget.getanimal.cageID} ')
            ],
          ),
        ),
      ),
    );
  }

  //ประวัติการรักษาล่าสุด
  Widget medicalHistory() {
    return FutureBuilder<MedHis>(
          future: getMedHis(),
          builder:
              (BuildContext context, AsyncSnapshot<MedHis> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: _heading('ประวัติการรักษาล่าสุด', 35.0, 185.0)),
              SizedBox(
                height: 10,
              ),
              _buildfont('วันที่ : ', '${formatDateFromString(snapshot.data!.latest!.date.toString())}'),
              _buildfont('การรักษา : ', '${snapshot.data!.latest!.medicalName}'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  VetMedicalHistory(animalID: widget.animalID,
                            )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 220,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text('ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Colors.green,
                                )),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
      } else {
              return new Center(child: new CircularProgressIndicator());
            }
          },
        );
  }

  //ประวัติการฉีดวัคซีนล่าสุด
  Widget vaccineHistory() {
    return FutureBuilder<VacHis>(
          future: getVacHis(),
          builder:
              (BuildContext context, AsyncSnapshot<VacHis> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: _heading('ประวัติการฉีดวัคซีนล่าสุด', 35.0, 210.0)),
              SizedBox(
                height: 10,
              ),
              _buildfont('วันที่ : ', '${formatDateFromString(snapshot.data!.latest!.date.toString())}'),
              _buildfont('วัคซีน : ', '${snapshot.data!.latest!.vaccineName}'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  VetVaccineHistory(animalID:widget.animalID,)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 220,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text('ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Colors.green,
                                )),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
     } else {
              return new Center(child: new CircularProgressIndicator());
            }
          },
        );
  }

  //ขนาดและรูปแบบฟ้อนใน card
  Widget _buildfont(var title, var data) {
    return Container(
      child: Row(
        children: [
          Text(
            title?? 0,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            data?? 0,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

  //ขนาดและรูปแบบฟ้อนหัวข้อใน card
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

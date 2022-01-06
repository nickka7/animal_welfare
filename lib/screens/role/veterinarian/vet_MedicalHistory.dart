import 'dart:convert';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/MedHis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../constant.dart';

class VetMedicalHistory extends StatefulWidget {
  final String? animalID;
  const VetMedicalHistory({Key? key, required this.animalID}) : super(key: key);

  @override
  _VetMedicalHistoryState createState() => _VetMedicalHistoryState();
}

class _VetMedicalHistoryState extends State<VetMedicalHistory> {
  final storage = new FlutterSecureStorage();

  Future<MedHis> getAnimal() async {
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

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  @override
  void initState() {
    getAnimal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ประวัติการรักษา',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HexColor('#697825'),
            Colors.white,
          ],
        )),
        child: ListView(
          children: [buildListview()],
        ),
      ),
    );
  }

  Widget buildListview() {
    return FutureBuilder<MedHis>(
      future: getAnimal(),
      builder: (BuildContext context, AsyncSnapshot<MedHis> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                final animal = snapshot.data!.data![index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 70,
                            width: 280,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'การรักษา : ${animal.medicalName}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'เวลา : ${animal.time}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'วันที่ : ${formatDateFromString(animal.date.toString())}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

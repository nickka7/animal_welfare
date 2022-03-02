import 'dart:convert';

import 'package:animal_welfare/model/vaccine.dart';
import 'package:animal_welfare/model/vaccineHIs.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddVaccinate extends StatefulWidget {
  final String animalID;

  const AddVaccinate({Key? key, required this.animalID}) : super(key: key);

  @override
  _AddVaccinateState createState() => _AddVaccinateState();
}

class _AddVaccinateState extends State<AddVaccinate> {
  final _formKey = GlobalKey<FormState>();
  Future<void>? api;
  @override
  void initState() {
    super.initState();
    api = getVaccine();
  }

  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  int index = 0;
  List vaccineID = [];
  List vaccineName = [];

  Future<bool> getVaccine() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getVaccineUsable'),
        headers: {"authorization": 'Bearer $token'});
    //print('response.body ${response.body}');

    List jsonData = json.decode(response.body)['data'];

    // print(jsonData);
    for (int i = 0; i < jsonData.length; i++) {
      vaccineID.add(
        jsonData[i]['vaccineID'],
      );
      vaccineName.add(
        jsonData[i]['vaccineName'],
      );
    }

    print(vaccineID);

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'เพิ่มการฉีดวัคซีน',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<void>(
            future: api,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: [Text('data')],
                          ),
                        ),
                        Container(
                          height: 58,
                          width: double.infinity,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side:
                                    BorderSide(width: 1, color: Colors.black45),
                              ),
                              onPressed: () {
                                _vaccinePicker(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    vaccineID[index].toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return new Center(child: new CircularProgressIndicator());
              }
            }));
  }

  void _vaccinePicker(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: vaccineID.map((item) {
                    return Center(
                      child: Text(
                        '${item.toString()} ${vaccineName[0]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.index = index;
                      final item = vaccineID[index];

                      print('selected $item');
                    });
                  },
                  diameterRatio: 1,
                  useMagnifier: true,
                  magnification: 1.3,
                ),
              ),
              CupertinoButton(
                child: Text('ยืนยัน'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

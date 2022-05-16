import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../model/meetingHis.dart';
import 'roomPicker.dart';

class BuildPicker extends StatefulWidget {
  const BuildPicker({Key? key}) : super(key: key);

  @override
  State<BuildPicker> createState() => _BuildPickerState();
}

class _BuildPickerState extends State<BuildPicker> {
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;
  List builds = [];

  Future<Builds> getshowBuild() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/showBuild'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = Builds.fromJson(jsonDecode(response.body));
    print('$jsonData');
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'จองห้องประชุม',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(child: _builds()),
    );
  }

  Widget _builds() {
    return FutureBuilder<Builds>(
      future: getshowBuild(),
      builder: (BuildContext context, AsyncSnapshot<Builds> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: ListView.builder(
                itemCount: snapshot.data?.data!.length,
                itemBuilder: (BuildContext context, int index) {
                   return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Card(
              elevation: 5,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoomPicker(
                            getbuild : snapshot.data?.data![index].build
                          )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 250,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'ตีก : ${snapshot.data!.data![index].build}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                          size: 40,
                        )
                      ],
                    ),
                  )),
            ),
          );
                }))
          );
          }
         else {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
        }
        
        );
        }
  }
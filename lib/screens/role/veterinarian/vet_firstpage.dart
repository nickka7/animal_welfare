import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/Schedule.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_searchAnimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class VetFirstpage extends StatefulWidget {
  const VetFirstpage({Key? key}) : super(key: key);

  @override
  _VetFirstpageState createState() => _VetFirstpageState();
}

class _VetFirstpageState extends State<VetFirstpage> {
  final storage = new FlutterSecureStorage();

  Future<ScheduleData> getSchedule() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getSchedule'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = ScheduleData.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'สัตวแพทย์',
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
            children: [totalAnimal(), _workSchedule()],
          ),
        ),
      ),
    );
  }

  Widget totalAnimal() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('สัตว์ภายใต้การดูแล',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Card(
              elevation: 5,
              // ignore: deprecated_member_use
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VetSearch()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 75,
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('จำนวนสัตว์ทั้งหมด : 15 ตัว',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('ช้าง 5 ตัว',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('เสือ 10 ตัว',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              )
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
          ),
        ],
      ),
    );
  }

  Widget _workSchedule() {
    return FutureBuilder(
      future: getSchedule(),
      builder: (BuildContext context, AsyncSnapshot<ScheduleData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var responseApi = snapshot.data;
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('ตารางงาน',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: HexColor('#697825'), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                          itemCount: responseApi!.data!.length,
                          itemBuilder: (BuildContext context, int index) { 
                            return  
                            Text('${responseApi.data![index].startTime} ${responseApi.data![index].scheduleName} ',
                                style: TextStyle(fontSize: 16));

                           },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

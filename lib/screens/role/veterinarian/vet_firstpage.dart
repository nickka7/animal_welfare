import 'dart:convert';
import 'package:animal_welfare/model/all_animals_with_role.dart';
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

  /* @override
  void initState() {
    getAnimal();
    getSchedule();
    super.initState();
  }*/

  Future<AllAnimalsWithRole> getAnimal() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getAnimalWithRole'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = AllAnimalsWithRole.fromJson(jsonDecode(response.body));
    print('$jsonData');
    return jsonData;
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('hh:mm');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor('#697825'),
                Colors.white,
              ],
            )),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Container(
                        child: Text(
                          '${DateFormat("d ", 'th').format(date)}',
                          style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          '${DateFormat("MMMM yyyy", 'th').format(date)}',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("#F2F2F2"),
                          borderRadius:
                              BorderRadius.only(topRight: (Radius.circular(60))),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 25),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                totalAnimal(),
                                _workSchedule()
                              ],
                            ),
                          ),
                        ),
                      ),
                )
              ],
            )));
  }

  Widget totalAnimal() {
    return FutureBuilder<AllAnimalsWithRole>(
      future: getAnimal(),
      builder:
          (BuildContext context, AsyncSnapshot<AllAnimalsWithRole> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: _heading('สัตว์ภายใต้การดูแล', 35.0, 190.0)),
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
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                     
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 160,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.data!.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return Text(
                                                  '${snapshot.data!.data![index].animalName} ${snapshot.data!.data![index].amount} ตัว',
                                                  style: TextStyle(fontSize: 16,color: Colors.black));
                                            },
                                          ),
                                        ),
                                      ),
                             
                                    ],
                                  ),
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
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
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
                      child: _heading('ตารางงาน', 35.0, 120.0)),
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
                            return Text(
                                '${formatDateFromString(responseApi.data![index].startDate.toString())} ${responseApi.data![index].scheduleName} ',
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
        return Container();
      },
    );
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

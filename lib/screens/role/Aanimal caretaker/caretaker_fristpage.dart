import 'dart:convert';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/Schedule.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/model/weather.dart';
import 'package:animal_welfare/screens/role/Aanimal%20caretaker/caretaker_searchAnimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../constant.dart';

class CaretakerFirstPage extends StatefulWidget {
  const CaretakerFirstPage({Key? key}) : super(key: key);

  @override
  _CaretakerFirstPageState createState() => _CaretakerFirstPageState();
}

class _CaretakerFirstPageState extends State<CaretakerFirstPage> {
  final storage = new FlutterSecureStorage();

  Future<WeatherData> getWeather() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getWeather'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = WeatherData.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }

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

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('hh:mm');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  DateTime today = DateTime.now();
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
          // width: ,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
            colors: [
              Colors.blue,
              Colors.blue.shade200,
            ],
          )),
          child: FutureBuilder(
            future: getWeather(),
            builder:
                (BuildContext context, AsyncSnapshot<WeatherData> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var responseApi = snapshot.data;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              'วันนี้, ${DateFormat("d MMMM ", 'th').format(today)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            child: Text(
                              '${responseApi!.data![0].temperature}',
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.air_outlined, color: Colors.white),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'ความกดอากาศ ${responseApi.data![0].airpressure} km/hr',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.invert_colors, color: Colors.white),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'ความชื้น ${responseApi.data![0].moisture} %',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("#F2F2F2"),
                          borderRadius: BorderRadius.only(
                              topRight: (Radius.circular(60))),
                        ),
                        child: totalAnimal(),
                      ),
                    )
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
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
                                builder: (context) => const SearchAnimalData()),
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

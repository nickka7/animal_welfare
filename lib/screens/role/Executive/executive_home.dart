// import 'dart:ffi';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:animal_welfare/model/get_sky_line.dart';
import 'package:animal_welfare/screens/SearchAllAnimal.dart';
import 'package:animal_welfare/screens/role/Executive/executive_employee.dart';
import 'package:animal_welfare/screens/role/Executive/executive_visitors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyExecutiveHome extends StatefulWidget {

  const MyExecutiveHome({Key? key,}) : super(key: key);

  @override
  _MyExecutiveHomeState createState() => _MyExecutiveHomeState();
}

class _MyExecutiveHomeState extends State<MyExecutiveHome> {
  DateTime myDateTime = DateTime.now();

  Future<GetFlightArea> loadFlightArea() async {
    Uri url = Uri.parse(
        'https://flight-data4.p.rapidapi.com/get_area_flights?latitude=13.0003022&longitude=96.9923911');

    http.Response response = await http.get(url, headers: {
      "x-rapidapi-host": "flight-data4.p.rapidapi.com",
      "x-rapidapi-key": "8995a8cc8cmshe10cb8d52233a86p11c409jsn27b93c7616c2",
      "Content-Type": "application/json"
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      return GetFlightArea.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed');
    }
  }

  late List<TotalPeople> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F7F7F7"),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: HexColor("#697825")),
          ),
          centerTitle: true,
          title: Text('ผู้บริหาร', style: const TextStyle(color: Colors.white)),
        ),
        body: FutureBuilder(
          builder:
              (BuildContext context, AsyncSnapshot<GetFlightArea> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              CircularProgressIndicator();
              print('circle waiting');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              print('Done');

              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    // SfCartesianChart(series: <ChartSeries>[
                    //   LineSeries<TotalPeople, double>(dataSource: _chartData,
                    //   xValueMapper: (TotalPeople count, _) => count.month,
                    //   yValueMapper: (TotalPeople count, _) => count.count)
                    // ]),

                    Container(
                      height: 100,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        child: Flexible(
                            child: Row(
                          children: <Widget>[
                            buildStatCard('จำนวนผู้เข้าชมสวนสัตว์', 5, 5,
                                HexColor("#9B7401"))
                          ],
                        )),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuantityVisitors()),
                          ),
                        },
                      ),
                    ),
                    Flexible(
                        child: Row(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: 200,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            child: buildStatCard(
                                '     เจ้าหน้าที่\nที่มาปฏิบัติงาน',
                                5,
                                5,
                                HexColor("#3B5998")),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuantityEmployee()),
                              ),
                            },
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: 190,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            child: buildStatCard(
                                'จำนวนสัตว์', 5, 5, HexColor("#28B446")),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchAllAnimal()),
                              ),
                            },
                          ),
                        ),
                      ],
                    )),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                                'อัพเดทข้อมูลล่าสุด : ${DateFormat("dd/MM/yyyy HH:mm").format(myDateTime)}',
                                textAlign: TextAlign.right)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return new Center(child: new CircularProgressIndicator());
            }
          },
          future: loadFlightArea(),
        ));
  }

  Expanded buildStatCard(String title, int count, int add, HexColor color) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 4.0),
            blurRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Center(
            child: Text(
              '${NumberFormat("###,###").format(count)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              '[+ ${NumberFormat("###,###").format(add)}]',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ));
  }

  List<TotalPeople> getChartData() {
    final List<TotalPeople> chartData = [
      TotalPeople(1, 20000),
      TotalPeople(2, 20000),
      TotalPeople(3, 20000),
      TotalPeople(4, 20000),
      TotalPeople(5, 20000),
    ];
    return chartData;
  }
}

class TotalPeople {
  TotalPeople(this.month, this.count);
  final double month;
  final double count;
}

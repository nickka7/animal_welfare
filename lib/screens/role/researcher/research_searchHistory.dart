import 'dart:convert';
import 'package:animal_welfare/screens/role/researcher/research_HistoryDetail.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/research.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class ResearchHistory extends StatefulWidget {
  const ResearchHistory({Key? key}) : super(key: key);

  @override
  _ResearchHistoryState createState() => _ResearchHistoryState();
}

class _ResearchHistoryState extends State<ResearchHistory> {
  final storage = new FlutterSecureStorage();

  Future<ResearchData> getresearch() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getResearchData'),
        headers: {"authorization": 'Bearer $token'});

    print(response.body);
    var jsonData = ResearchData.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('ข้อมูลงานวิจัยสัตว์'),
          centerTitle: true,
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
            children: [
              // buildSearch(),
              _buildListView(),
            ],
          ),
        ),
      );

  Widget _buildListView() {
    return FutureBuilder<ResearchData>(
      future: getresearch(),
      builder: (BuildContext context, AsyncSnapshot<ResearchData> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Card(
                  elevation: 5,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResearchHistoryDetail(
                                  getResearch: snapshot.data!.data![index])),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 90,
                              width: 270,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'รหัสการเพาะพันธุ์ : ${snapshot.data!.data![index].researchID}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'ชื่อการเพาะพันธุ์ : ${snapshot.data!.data![index].researchName}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'ชนิด : ${snapshot.data!.data![index].typeName}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'อัพเดตล่าสุด  ${formatDateFromString(snapshot.data!.data![index].date)}',
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
            },
          );
        } else {
          return Center(
            child: //Text('no data')
            CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

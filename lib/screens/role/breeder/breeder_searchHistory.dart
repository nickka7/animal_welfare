import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/breeding.dart';
import 'package:animal_welfare/screens/role/breeder/breeder_HistoryDetail.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../haxColor.dart';
class BreederSearchHistory extends StatefulWidget {
  const BreederSearchHistory({Key? key}) : super(key: key);

  @override
  _BreederSearchHistoryState createState() => _BreederSearchHistoryState();
}

class _BreederSearchHistoryState extends State<BreederSearchHistory> {
  final storage = new FlutterSecureStorage();

  Future<BreedingData> getBreeding() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getBreedingData'),
        headers: {"authorization": 'Bearer $token'});

    print(response.body);
    var jsonData = BreedingData.fromJson(jsonDecode(response.body));
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
          title: Text('ข้อมูลสัตว์'),
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
              buildBook(),
            ],
          ),
        ),
      );

  /* Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "รหัสการเพาะพันธุ์,ชื่อการเพาะพันธุ์,ชนิดของสัตว์",
        onChanged: searchBook,
      );

  Future searchBook(String query) async {
    final books = await getBreeding(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.data = books;
    });
  }*/

  Widget buildBook() => FutureBuilder<BreedingData>(
      future: getBreeding(),
      builder: (BuildContext context, AsyncSnapshot<BreedingData> snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                // final data = data[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Card(
                    elevation: 5,
                    child: TextButton(
                        onPressed: () {
                              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  BreederHistoryDetail(
                      getBreeding: snapshot.data!.data![index])),
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
                                        'รหัสการเพาะพันธุ์ : ${snapshot.data!.data![index].breedingID}',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'ชื่อการเพาะพันธุ์ : ${snapshot.data!.data![index].breedingName}',
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
              });
        } else {
          return new Center(child: new CircularProgressIndicator());
        }
      });
}
  /*Widget _buildListView() {
    return FutureBuilder<List<Data>>(
      future: getBreeding(),
      builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (snapshot.hasData) {
          return Container(
            child: breeding.isNotEmpty
                ? ListView.builder(
                    itemCount: breeding.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Card(
                        elevation: 5,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BreederHistoryDetail()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 90,
                                    width: 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'รหัสการเพาะพันธุ์ : ${breeding[index].breedingID}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'ชื่อการเพาะพันธุ์ : ${breeding[index].breedingName}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'ชนิด : ${breeding[index].typeName}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'อัพเดทล่าสุด : ${breeding[index].date}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
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
                    ),
                  )
                : const Text(
                    'ไม่พบข้อมูล',
                    style: TextStyle(fontSize: 18),
                  ),
          );
        } else {
          return new Center(child: Text('no data'));
        }
      },
    );
  }*/

  /*Widget buildAnimal() => FutureBuilder<List<Data>>(
        future: getBreeding(),
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: breeding.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Card(
                      elevation: 5,
                      child: TextButton(
                          onPressed: () {
                            /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VetAnimalData(
                              getanimal: book,
                            )),
                  );*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 70,
                                  width: 250,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Animal ID : ${breeding[index].breedingID}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'ชนิด : ${breeding[index].typeName}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'ชื่อ : ${breeding[index].breedingName}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
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
                });
          } else {
            return new Center(child: Text('no data'));
          }
        },
      );
}*/

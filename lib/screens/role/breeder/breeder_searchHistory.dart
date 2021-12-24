import 'package:animal_welfare/screens/role/breeder/breeder_HistoryDetail.dart';
import 'package:flutter/material.dart';

import '../../../haxColor.dart';

class BreederSearchHistory extends StatefulWidget {
  const BreederSearchHistory({ Key? key }) : super(key: key);

  @override
  _BreederSearchHistoryState createState() => _BreederSearchHistoryState();
}

class _BreederSearchHistoryState extends State<BreederSearchHistory> {
  final List<Map<String, dynamic>> _allAnimals = [
    {"id": "123456", "name": "การเพาะพันธุ์", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "223456", "name": "การเพาะพันธุ์", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "3", "name": "การเพาะพันธุ์", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "4", "name": "การเพาะพันธุ์", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "5", "name": "การเพาะพันธุ์", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "6", "name": "การเพาะพันธุ์", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "7", "name": "การเพาะพันธุ์", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "8", "name": "การเพาะพันธุ์", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "9", "name": "การเพาะพันธุ์", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "10", "name": "การเพาะพันธุ์", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
  ];

  List<Map<String, dynamic>> _foundAnimals = [];

  @override
  initState() {
    // at the beginning, all animals are shown
    _foundAnimals = _allAnimals;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all animals
      results = _allAnimals;
    } else {
      results = _allAnimals
          .where((_allAnimals) => _allAnimals["name"] 
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      _foundAnimals = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ข้อมูลการเพาะพันธุ์สัตว์แต่ละชนิด',
          style: TextStyle(color: Colors.white,fontSize: 14),
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
            )
          ),
          child: ListView(
        children: [
          _search(),
          _buildListView(),
        ],
      )),
    );
  }
  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.0,
        width: double.infinity,       
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
              fillColor: Colors.white,
               filled: true,
              labelText: "ค้นหา",
              hintText: "ชื่อการเพาะพันธุ์,ชนิดของสัตว์",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      child: _foundAnimals.isNotEmpty
          ? ListView.builder(
              itemCount: _foundAnimals.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Card(
                  elevation: 5,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BreederHistoryDetail()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'รหัสการเพาะพันธุ์ : ${_foundAnimals[index]["id"].toString()}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                   Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'ชื่อการเพาะพันธุ์ : ${_foundAnimals[index]["name"].toString()}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'ชนิด : ${_foundAnimals[index]["type"].toString()}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'อัพเดทล่าสุด : ${_foundAnimals[index]["Date"].toString()}',
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
              ),
            )
          : const Text(
              'ไม่พบข้อมูล',
              style: TextStyle(fontSize: 18),
            ),
    );
  }
}
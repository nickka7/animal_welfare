import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/researcher/research_HistoryDetail.dart';
import 'package:flutter/material.dart';

class ResearchHistory extends StatefulWidget {
  const ResearchHistory({ Key? key }) : super(key: key);

  @override
  _ResearchHistoryState createState() => _ResearchHistoryState();
}

class _ResearchHistoryState extends State<ResearchHistory> {
      final List<Map<String, dynamic>> _allAnimals = [
    {"id": "123456", "name": "การวิจัย", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "223456", "name": "การวิจัย", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "3", "name": "การวิจัย", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "4", "name": "การวิจัย", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "5", "name": "การวิจัย", "type": "ช้าง","Date" : "18 ตุลาคม 2564"},
    {"id": "6", "name": "การวิจัย", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "7", "name": "การวิจัย", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "8", "name": "การวิจัย", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "9", "name": "การวิจัย", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
    {"id": "10", "name": "การวิจัย", "type": "เสือ","Date" : "18 ตุลาคม 2564"},
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
          'ข้อมูลงานวิจัยสัตว์แต่ละชนิด',
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
              hintText: "ชื่องานวิจัย,ชนิดของสัตว์",
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
                              builder: (context) => const ResearchHistoryDetail()),
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
                                      'รหัสงานวิจัย : ${_foundAnimals[index]["id"].toString()}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                   Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'ชื่องานวิจัย : ${_foundAnimals[index]["name"].toString()}',
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
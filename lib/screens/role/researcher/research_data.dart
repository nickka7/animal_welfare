import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class ResearchData extends StatefulWidget {
  const ResearchData({ Key? key }) : super(key: key);

  @override
  _ResearchDataState createState() => _ResearchDataState();
}

class _ResearchDataState extends State<ResearchData> {
   final List<Map<String, dynamic>> _allAnimals = [
    {"id": "1", "name": "Andy", "age": 29, "type": "ช้าง"},
    {"id": "2", "name": "Aragon", "age": 40, "type": "ช้าง"},
    {"id": "3", "name": "Bob", "age": 5, "type": "ช้าง"},
    {"id": "4", "name": "Barbara", "age": 35, "type": "ช้าง"},
    {"id": "5", "name": "Candy", "age": 21, "type": "ช้าง"},
    {"id": "6", "name": "Colin", "age": 55, "type": "เสือ"},
    {"id": "7", "name": "Audra", "age": 30, "type": "เสือ"},
    {"id": "8", "name": "Banana", "age": 14, "type": "เสือ"},
    {"id": "9", "name": "Caversky", "age": 100, "type": "เสือ"},
    {"id": "10", "name": "Becky", "age": 32, "type": "เสือ"},
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
          'ข้อมูลสัตว์',
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
              hintText: "ชื่อสัตว์,รหัสสัตว์,ชนิดของสัตว์",
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
                     /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const animalData()),
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
                                      'Animal ID : ${_foundAnimals[index]["id"].toString()}',
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
                                      'ชื่อ : ${_foundAnimals[index]["name"].toString()}',
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
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/Aanimal%20caretaker/caretaker_searchAnimal.dart';
import 'package:flutter/material.dart';

class SearchAnimalType extends StatefulWidget {
  const SearchAnimalType({Key? key}) : super(key: key);

  @override
  _SearchAnimalTypeState createState() => _SearchAnimalTypeState();
}

class _SearchAnimalTypeState extends State<SearchAnimalType> {
  final List<Map<String, dynamic>> _allAnimals = [
    {"type": "ช้าง", "number": "3"},
    {"type": "ม้าลาย", "number": "3"},
    {"type": "เสือ", "number": "3"},
    {"type": "สิงโต", "number": "3"},
    {"type": "ช้าง", "number": "3"},
    {"type": "ม้าลาย", "number": "3"},
    {"type": "เสือ", "number": "3"},
    {"type": "สิงโต", "number": "3"},
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
          .where((_allAnimals) => _allAnimals["type"]
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
          'จำนวนสัตว์',
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
              hintText: "ชนิดของสัตว์",
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
                              builder: (context) =>  SearchAnimalData()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${_foundAnimals[index]["type"].toString()}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${_foundAnimals[index]["number"].toString()} ตัว',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
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

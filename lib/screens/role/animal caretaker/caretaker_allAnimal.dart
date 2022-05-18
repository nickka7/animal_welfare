import 'dart:async';

import 'package:animal_welfare/api/allAnimal.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:animal_welfare/screens/AllanimalData.dart';
import 'package:animal_welfare/screens/role/animal%20caretaker/addAllAnimal.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/material.dart';



class Allanimal extends StatefulWidget {
  const Allanimal({ Key? key }) : super(key: key);

  @override
  _AllanimalState createState() => _AllanimalState();
}

class _AllanimalState extends State<Allanimal> {
 @override
  void initState() {
    // getAnimal();
    init();
    super.initState();
  }

  List<Bio> bios = [];
  String query = '';
  // Timer? debouncer;

  Future init() async {
    final bios = await AllAnimalsAPI.getAllAnimals(query);

    setState(() => this.bios = bios);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            buildSearch(),
            buildListview(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddAnimal()),
                          ).then((value) async {
            await init();
            setState(() {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (a, b, c) => Allanimal(),
                  transitionDuration: Duration(milliseconds: 100),
                ),
              );
            });
          });
                        },
                        backgroundColor: HexColor("#697825"),
                        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildListview() {
    return ListView.builder(
        itemCount: bios.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          final animal = bios[index];
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Card(
              elevation: 5,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimalData(
                            getBio: bios[index],
                          )),
                    );
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
                                  'Animal ID : ${animal.animalID}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'ชนิด : ${animal.typeName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ชื่อสัตว์ : ${animal.animalName}',
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
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: "ชื่อสัตว์,รหัสสัตว์,ชนิดของสัตว์",
    onChanged: searchAnimal,
  );

  void searchAnimal(String query) async {
    final bios = await AllAnimalsAPI.getAllAnimals(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.bios = bios;
    });
  }
}
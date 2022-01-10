import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_AnimalData.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class VetSearch extends StatefulWidget {
  const VetSearch({Key? key}) : super(key: key);

  @override
  _VetSearchState createState() => _VetSearchState();
}

class _VetSearchState extends State<VetSearch > {
  
    @override
  void initState() {
    super.initState();
    init();
  }

  final storage = new FlutterSecureStorage();

  static Future<List<Bio>> getAllAnimals(String query) async {
    String endPoint = Constant().endPoint;
    final url = Uri.parse(
        '$endPoint/api/getAnimalWithRole');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final allanimals = json.decode(response.body);
      final List bio = allanimals['bio'];

      return bio.map((json) => Bio.fromJson(json)).where((animal) {
        final animalTypeLower = animal.typeName!.toLowerCase();
        final animalNameLower = animal.animalName!.toLowerCase();
        final searchLower = query;

        return animalTypeLower.contains(searchLower) ||
            animalNameLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
  

List<Bio> animal = [];
  String query = '';

  Future init() async {
    dynamic animal = await getAllAnimals(query);

    setState(() => this.animal = animal );
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
      );
  }
  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "ชื่อสัตว์,รหัสสัตว์,ชนิดของสัตว์",
        onChanged: searchAnimal,
      );

  Future searchAnimal(String query) async {
    dynamic animal = await getAllAnimals(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.animal = animal;
    });
  }
  Widget buildListview(){
   
          return ListView.builder(
      itemCount: animal.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
       // final animal = snapshot.data!.bio![index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Card(
            elevation: 5,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  VetAnimalData(
                      animalID : animal[index].animalID,
                      getanimal: animal[index],)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           
                 Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Animal ID : ${animal[index].animalID}',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'ชนิด : ${animal[index].typeName}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'ชื่อสัตว์ : ${animal[index].animalName}',
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
  /*List<Book> books = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final books = await BooksApi.getBooks(query);

    setState(() => this.books = books);
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
              buildSearch(),
              buildAnimal(),
            ],
          ),
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "ชื่อสัตว์,รหัสสัตว์,ชนิดของสัตว์",
        onChanged: searchBook,
      );

  Future searchBook(String query) async {
    final books = await BooksApi.getBooks(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.books = books;
    });
  }

  Widget buildAnimal() => ListView.builder(
      itemCount: books.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final book = books[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Card(
            elevation: 5,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VetAnimalData(
                              getanimal: book,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Animal ID : ${book.id}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ชนิด : ${book.title}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'ชื่อ : ${book.author}',
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
      });*/
}

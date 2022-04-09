
import 'package:animal_welfare/api/AllAnimalWithRole.dart';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/screens/role/animal%20caretaker/caretaker_addAnimal.dart';
import 'package:animal_welfare/screens/role/animal%20caretaker/caretaker_animalData.dart';

import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/material.dart';

class SearchAnimalData extends StatefulWidget {
  const SearchAnimalData({Key? key}) : super(key: key);

  @override
  _SearchAnimalDataState createState() => _SearchAnimalDataState();
}

class _SearchAnimalDataState extends State<SearchAnimalData> {
  @override
  void initState() {
    init();
    super.initState();
  }

  // final storage = new FlutterSecureStorage();
  // Future<AllAnimalsWithRole> getAnimal() async {
  //   String? token = await storage.read(key: 'token');
  //   String endPoint = Constant().endPoint;
  //   var response = await http.get(Uri.parse('$endPoint/api/getAnimalWithRole'),
  //       headers: {"authorization": 'Bearer $token'});
  //   print(response.body);
  //   var jsonData = AllAnimalsWithRole.fromJson(jsonDecode(response.body));
  //   print('$jsonData');
  //   return jsonData;
  // }

  List<Bio> bios = [];
  String query = '';
  // Timer? debouncer;

  Future init() async {
    final bios = await AllAnimalsWithRoleAPI.getAllAnimalsWithRole(query);

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
      body:RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => SearchAnimalData(),
              transitionDuration: Duration(milliseconds: 400),
            ),
          ),
    child : Container(
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
      )),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddAnimalWithRole()),
                          ).then((value) =>
                              setState(() {}));
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

                            getanimal: bios[index],
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
    final bios = await AllAnimalsWithRoleAPI.getAllAnimalsWithRole(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.bios = bios;
    });
  }

}

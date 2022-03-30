import 'dart:convert';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/animal%20caretaker/caretaker_searchAnimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddAnimalWithRole extends StatefulWidget {
  const AddAnimalWithRole({Key? key}) : super(key: key);

  @override
  State<AddAnimalWithRole> createState() => _AddAnimalWithRoleState();
}

class _AddAnimalWithRoleState extends State<AddAnimalWithRole> {
  final snackBar = SnackBar(content: Text('เพิ่มสัตว์เรียบร้อยแล้ว'));
  late FixedExtentScrollController scrollController;

  int index = 0;
  @override
  void initState() {
    super.initState();

    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    scrollController.dispose();
    super.dispose();
  }

  List animal = [];
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;
  Future<bool> getAnimal() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('$endPoint/api/getUsableAddAnimalUserID'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    // List jsonData = json.decode(response.body)['data'];
    final allanimals = json.decode(response.body);
    final List bio = allanimals['bio'];

    for (int i = 0; i < bio.length; i++) {
      animal.add(
          '${bio[i]['animalID']} ${bio[i]['animalName']} ${bio[i]['typeName']}');
    }
    print(animal);

    return true;
  }

  Future<String?> uploadData(url, data) async {
    // print(file!.path);
    String? token = await storage.read(key: 'token');
    var request = http.post(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          'animalID': data['animalID'],
        }));

    print(request);
  }

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เพิ่มสัตว์ที่ดูแล',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<void>(
          future: getAnimal(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Form(
                      // key: _formKey,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'ชื่อสัตว์',
                                style: TextStyle(fontSize: 18),
                              )),
                          Container(
                            height: 58,
                            width: double.infinity,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: Colors.black45),
                                ),
                                onPressed: () {
                                  scrollController.dispose();
                                  scrollController =
                                      FixedExtentScrollController(
                                          initialItem: index);
                                  _animalPicker(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      animal[index].toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(height: 70),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Map<String, String> data = {
                                    "animalID": animal[index].split(" ")[0]
                                  };
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.lightGreen[400],
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                          content: Text(
                                            'ยืนยันการเพิ่มสัตว์',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text(
                                                'ยกเลิก',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            CupertinoDialogAction(
                                                child: Text(
                                                  'ยืนยัน',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                                onPressed: () {
                                                  uploadData(
                                                          '${Constant().endPoint}/api/postAnimalWithRole',
                                                          data)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    final snackBar = SnackBar(
                                                        content: Text(
                                                            'เพิ่มสัตว์เรียบร้อยแล้ว'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }).then((value) => setState(
                                                            () {
                                                              SearchAnimalData();
                                                            },
                                                          ));
                                                })
                                          ],
                                        );
                                      });
                                },
                                child: Text('เสร็จสิ้น',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    primary: HexColor('#697825')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return new Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }

  void _animalPicker(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  scrollController: scrollController,
                  children: animal
                      .map((item) => Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.index = index;
                      final item = animal[index];
                      print('selected $item');
                    });
                  },
                  diameterRatio: 1,
                  useMagnifier: true,
                  magnification: 1.3,
                ),
              ),
              CupertinoButton(
                child: Text('ยืนยัน'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

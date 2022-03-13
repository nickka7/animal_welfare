import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:animal_welfare/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../haxColor.dart';

class AddAnimal extends StatefulWidget {
  const AddAnimal({Key? key}) : super(key: key);

  @override
  _AddAnimalState createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  final snackBar = SnackBar(content: Text('เพิ่มสัตว์เรียบร้อยแล้ว'));

  Future<void>? api;
  Future<void>? apicage;
  @override
  void initState() {
    super.initState();
    api = getAnimalType();
    apicage = getCage();
  }

  File? file; //dart.io
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();

   @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    weightController.dispose();
    super.dispose();
  }

  // bool _validate = false;
  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().pickImage(
        source: source,
      ); //maxHeight: 1000, maxWidth: 1000
      setState(() {
        file = File(object!.path);
      });
    } catch (e) {
      print('${e}123');
    }
  }

  final storage = new FlutterSecureStorage();

  Future<String?> uploadImageAndData(filepath, url, data) async {
    print(file!.path);
    String? token = await storage.read(key: 'token');
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    request.fields['animalName'] = data['animalName'];
    request.fields['animalType'] = data['animalType'];
    request.fields['weight'] = data['weight'];
    request.fields['age'] = data['age'];
    request.fields['gender'] = data['gender'];
    request.fields['cage'] = data['cage'];
    Map<String, String> headers = {
      "authorization": "Bearer $token",
    };
    request.headers
        .addAll(headers); //['authorization'] = data['Bearer $token'];
    var res = await request.send();
    print('${res.reasonPhrase}test');
    return res.reasonPhrase;
  }

  int animalTypeIndex = 0;
  int cageindex = 0;
  int genderindex = 0;
  int ageindex = 0;

  List animalType = [];
  List cage = [];
  final gender = [
    'ผู้',
    'เมีย',
  ];

  final age = List<String>.generate(100, (i) => '$i');

  String endPoint = Constant().endPoint;

  Future<bool> getAnimalType() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getAllAnimalType'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData = json.decode(response.body)['data'];

    for (int i = 0; i < jsonData.length; i++) {
      animalType.add(jsonData[i]['typeName']);
    }
    print(animalType);

    return true;
  }

  Future<bool> getCage() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getAllCageID'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData = json.decode(response.body)['data'];

    for (int i = 0; i < jsonData.length; i++) {
      cage.add(jsonData[i]['cageID']);
    }
    print(cage);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เพิ่มสัตว์ในสวนสัตว์',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<void>(
          future: api,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'ชื่อ',
                                style: TextStyle(fontSize: 18),
                              )),
                          TextFormField(
                            controller: nameController,
                            validator: (String? input) {
                              if (input!.isEmpty) {
                                return "กรุณากรอกชื่อ";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green.shade800,
                                        width: 2))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'ชนิดสัตว์',
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
                                  _animalPicker(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      animalType[animalTypeIndex].toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'เพศ',
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
                                  _sexPicker(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      gender[genderindex].toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'อายุ (ปี)',
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
                                  _agePicker(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      age[ageindex].toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'น้ำหนัก',
                                style: TextStyle(fontSize: 18),
                              )),
                          TextFormField(
                            controller: weightController,
                            validator: (String? input) {
                              if (input!.isEmpty) {
                                return "กรุณากรอกน้ำหนัก";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green.shade800,
                                        width: 2))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'กรง',
                                style: TextStyle(fontSize: 18),
                              )),
                              cageID(),
                          // Container(
                          //   height: 58,
                          //   width: double.infinity,
                          //   child: OutlinedButton(
                          //       style: OutlinedButton.styleFrom(
                          //         side: BorderSide(
                          //             width: 1, color: Colors.black45),
                          //       ),
                          //       onPressed: () {
                          //         _animalPicker(context);
                          //       },
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             animalType[animalTypeIndex].toString(),
                          //             style: TextStyle(color: Colors.black),
                          //           ),
                          //           Icon(
                          //             Icons.arrow_drop_down,
                          //             color: Colors.black,
                          //           )
                          //         ],
                          //       )),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 200,
                              width: double.infinity,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    side: BorderSide(
                                        width: 2, color: Colors.green),
                                  ),
                                  // color: Colors.green.shade800,
                                  child: Center(
                                    child: file == null
                                        ? Icon(
                                            Icons.camera_alt_outlined,
                                            size: 40,
                                          )
                                        : Image.file(file!),
                                  ),
                                  onPressed: () => _onButtonPress())),
                          SizedBox(height: 70),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  bool pass = _formKey.currentState!.validate();
                                  if (pass) {
                                    Map<String, String> data = {
                                      "animalName": nameController.text,
                                      "animalType": animalType[animalTypeIndex]
                                          .toString(),
                                      "age": age[ageindex].toString(),
                                      "gender": gender[ageindex].toString(),
                                      "cage": cage[cageindex].toString(),
                                      "weight": weightController.text,
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
                                                    print(
                                                        'before upload image');
                                                    uploadImageAndData(
                                                            file!.path,
                                                            '${Constant().endPoint}/api/postAnimalData',
                                                            data)
                                                        .then((value) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();

                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                            'เพิ่มสัตว์เรียบร้อยแล้ว'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                    });
                                                    
                                                  })
                                            ],
                                          );
                                        });
                                  }
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

  cageID() {
    return FutureBuilder<void>(
        future: apicage,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return Container(
              height: 58,
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.black45),
                  ),
                  onPressed: () {
                    _cagePicker(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cage[cageindex].toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      )
                    ],
                  )),
            );
          } else {
            return new Center(child: new CircularProgressIndicator());
          }
        });
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: animalType
                      .map((item) => Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.animalTypeIndex = index;
                      final item = animalType[index];
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

  void _cagePicker(context) {
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: cage
                      .map((item) => Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.cageindex = index;
                      final item = cage[index];
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

  void _sexPicker(context) {
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: gender
                      .map((item) => Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.genderindex = index;
                      final item = gender[index];
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

  void _agePicker(context) {
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: age
                      .map((item) => Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.ageindex = index;
                      final item = age[index];
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

  void _onButtonPress() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      )),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Camera'),
              onTap: () => chooseImage(ImageSource.camera),
            ),
            ListTile(
              title: Text('Gallery'),
              onTap: () => chooseImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

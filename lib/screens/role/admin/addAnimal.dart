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
  Future<void>? api;

  @override
  void initState() {
    super.initState();
    api = getAnimalType();
  }

  File? file; //dart.io
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
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
    request.fields['requestMessage'] = data['maintenanceDetail'];
    request.fields['location'] = data['location'];
    Map<String, String> headers = {
      "authorization": "Bearer $token",
    };
    request.headers
        .addAll(headers); //['authorization'] = data['Bearer $token'];
    var res = await request.send();
    print('${res.reasonPhrase}test');
    return res.reasonPhrase;
  }

  int index = 0;
  List animalType = [];
  String endPoint = Constant().endPoint;

  Future<bool> getAnimalType() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getAllAnimalType'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData2 = json.decode(response.body)['data'];

    for (int i = 0; i < jsonData2.length; i++) {
      animalType.add(jsonData2[i]['typeName']);
    }
    print(animalType);

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
                                      animalType[index].toString(),
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
                                return "กรุณากรอกนำหนัก";
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
                            height: 30,
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
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                bool pass = _formKey.currentState!.validate();
                                if (pass) {
                                  Map<String, String> data = {
                                    "Animalname": nameController.text,
                                    "animalType": animalType[index].toString(),
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
                                            'ยืนยันเพิ่มสัตว์',
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
                                                  print('before upload image');
                                                  uploadImageAndData(
                                                          file!.path,
                                                          '${Constant().endPoint}/api/postMaintenance',
                                                          data)
                                                      .then((value) {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    //  Navigator.of(context).pop();
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
                      this.index = index;
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

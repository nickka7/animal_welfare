import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddResearch extends StatefulWidget {
  const AddResearch({Key? key}) : super(key: key);

  @override
  _AddResearchState createState() => _AddResearchState();
}

class _AddResearchState extends State<AddResearch> {
 Future<void>? api;

  @override
  void initState() {
    super.initState();
    api = getAnimalType();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController =
      TextEditingController(); //ชื่อการวิจัย
  TextEditingController detailController =
      TextEditingController(); //รายละเอียดงานวิจัย

  int index = 0;



  List animalType = [];
  final storage = new FlutterSecureStorage();
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
          'researchName': data['researchName'],
          'animalType': data['animalType'],
          'detail': data['detail'],
          
        }));

    print(request);
    // print(data['showName']);
    // print(data['startDate']);
    // print(data['endDate']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เพิ่มงานวิจัย',
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
                                'ชื่องานวิจัย',
                                style: TextStyle(fontSize: 18),
                              )),
                          TextFormField(
                            controller: nameController,
                            validator: (String? input) {
                              if (input!.isEmpty) {
                                return "กรุณากรอกชื่องานวิจัย";
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
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'ชื่อชนิดสัตว์',
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
                            height: 30,
                          ),
                          
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'รายละเอียด',
                                style: TextStyle(fontSize: 18),
                              )),
                          TextFormField(
                            controller: detailController,
                            validator: (String? input) {
                              if (input!.isEmpty) {
                                return "กรุณากรอกรายละเอียด";
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
                          SizedBox(height: 70),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                bool pass = _formKey.currentState!.validate();
                                if (pass) {
                                  Map<String, String> data = {
                                    "researchName": nameController.text,
                                    "animalType": animalType[index].toString(),
                                    "detail": detailController.text
                                  };
                                  uploadData(
                                          '${Constant().endPoint}/api/postResearchData',
                                          data)
                                      .then((value) {
                                    Navigator.of(context).pop();
                                    final snackBar = SnackBar(
                                        content: Text(
                                            'เพิ่มงานวิจัยเรียบร้อยแล้ว'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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

}

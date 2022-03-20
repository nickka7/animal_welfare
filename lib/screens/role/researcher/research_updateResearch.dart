import 'dart:convert';
import 'package:animal_welfare/model/research.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UpdateResearch extends StatefulWidget {
  final Data getResearch;
  const UpdateResearch({Key? key, required this.getResearch}) : super(key: key);

  @override
  State<UpdateResearch> createState() => _UpdateResearchState();
}

class _UpdateResearchState extends State<UpdateResearch> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(); //ชื่อการวิจัย
  TextEditingController detailController =TextEditingController(); //รายละเอียดงานวิจัย
  late FixedExtentScrollController scrollController;

  Future<void>? api;

  @override
  void initState() {
    super.initState();
    api = getAnimalType();
    scrollController = FixedExtentScrollController(initialItem: index);
  }
         @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    detailController.dispose();
    scrollController.dispose();
    super.dispose();
  }

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
    index = animalType.indexOf('${widget.getResearch.typeName}');
    print(animalType);

    return true;
  }

  Future<String?> uploadData(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.put(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          // 'userID' : data['userID'],
          'researchName': data['researchName'],
          'animalType': data['animalType'],
          'detail': data['detail'],
        }));
    print(data['scheduleName']);
    print(' ${request}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'แก้ไขงานวิจัย',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (a, b, c) => UpdateResearch(getResearch: widget.getResearch,),
            transitionDuration: Duration(milliseconds: 400),
          ),
        ),
        child: FutureBuilder<void>(
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
                            // validator: (String? input) {
                            //   if (input!.isEmpty) {
                            //     return "กรุณากรอกชื่องานวิจัย";
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                                hintText: '${widget.getResearch.researchName}',
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
                                'รายละเอียด',
                                style: TextStyle(fontSize: 18),
                              )),
                          // TextFormField(
                          //   controller: detailController,
                          //   validator: (String? input) {
                          //     if (input!.isEmpty) {
                          //       return "กรุณากรอกรายละเอียด";
                          //     }
                          //     return null;
                          //   },
                          //   decoration: InputDecoration(
                          //       border: OutlineInputBorder(),
                          //       focusedBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.green.shade800,
                          //               width: 2))),
                          // ),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200.0,
                              ),
                              child: new Scrollbar(
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  child: SizedBox(
                                    height: 190.0,
                                    child: new TextField(
                                      controller: detailController,
                                      maxLines: 100,
                                      decoration: new InputDecoration(
                                        hintText: '${widget.getResearch.researchDetail}',
                                        border: InputBorder.none,
                                       // hintText: 'เพิ่มรายละเอียดที่นี่',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                Colors.lightGreen[400],
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                          content: Text(
                                            'ยืนยันการแก้ไขงานวิจัย',
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
                                                          '${Constant().endPoint}/api/updateResearchData/${widget.getResearch.researchID}',
                                                          data)
                                                      .then((value) {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    final snackBar = SnackBar(
                                                        content: Text(
                                                            'แก้ไขงานวิจัยเรียบร้อยแล้ว'));
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
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return new Center(child: new CircularProgressIndicator());
            }
          }),),
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
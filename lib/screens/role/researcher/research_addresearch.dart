import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddResearch extends StatefulWidget {
  const AddResearch({Key? key}) : super(key: key);

  @override
  _AddResearchState createState() => _AddResearchState();
}

class _AddResearchState extends State<AddResearch> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController =
      TextEditingController(); //ชื่อการเพาะพันธุ์

  TextEditingController detailController =
      TextEditingController(); //รายละเอียดการเพาะพันธุ์

  int index = 0;
  final animal = ['ช้าง', 'นกแก้ว', 'ลิง', 'แมวน้ำ'];

  int index1 = 0;
  final status = [
    'pass',
    'failed',
  ];

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
      body: SingleChildScrollView(
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
                                color: Colors.green.shade800, width: 2))),
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
                          side: BorderSide(width: 1, color: Colors.black45),
                        ),
                        onPressed: () {
                          _animalPicker(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              animal[index],
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 30),
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
                                color: Colors.green.shade800, width: 2))),
                  ),
                  SizedBox(height: 70),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // bool pass = _formKey.currentState!.validate();
                        // if (pass) {
                        //   Map<String, String> data = {
                        //     "showName": show[index].toString(),
                        //     "startDate": startDate.toString(),
                        //     "endDate": endDate.toString()
                        //   };
                        //   uploadData(
                        //           '${Constant().endPoint}/api/postShow', data)
                        //       .then((value) {
                        //     Navigator.of(context).pop();
                        //     final snackBar = SnackBar(
                        //         content: Text('เพิ่มรอบการแสดงเรียบร้อยแล้ว'));
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(snackBar);
                        //   });
                        // }
                      },
                      child: Text('เสร็จสิ้น',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          primary: HexColor('#697825')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                  itemExtent: 30,
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: animal
                      .map((item) => Center(
                            child: Text(
                              item,
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

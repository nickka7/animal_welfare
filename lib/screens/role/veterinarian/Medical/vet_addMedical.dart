import 'package:animal_welfare/api/medical.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddMedical extends StatefulWidget {
  final Bio getanimal;
  const AddMedical({Key? key, required this.getanimal}) : super(key: key);

  @override
  _AddMedicalState createState() => _AddMedicalState();
}

class _AddMedicalState extends State<AddMedical> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  
   @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    detailController.dispose();
    super.dispose();
  }

  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  final MedicalApi medicalApi = MedicalApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เพิ่มการรักษา',
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
                  Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: _heading('ข้อมูล', 35.0, 80.0)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildfont('ANIMAL ID : ',
                                      '${widget.getanimal.animalID}'),
                                  _buildfont('ชนิด : ',
                                      '${widget.getanimal.typeName}'),
                                  _buildfont(
                                      'เพศ : ', '${widget.getanimal.gender}'),
                                  _buildfont(
                                      'อายุ : ', '${widget.getanimal.age} ปี'),
                                  _buildfont('น้ำหนัก : ',
                                      '${widget.getanimal.weight} กิโลกรัม'),
                                  _buildfont(
                                      'กรง : ', '${widget.getanimal.cageID} ')
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'การรักษา',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: nameController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกการรักษา";
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
                    height: 20,
                  ),
                 Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'รายละเอียดเพิ่มเติม',
                                style: TextStyle(fontSize: 18),
                              )),
                         
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
                                        border: InputBorder.none,
                                        hintText: 'เพิ่มรายละเอียดที่นี่',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        bool pass = _formKey.currentState!.validate();
                        if (pass) {
                          Map<String, String> data = {
                            "medicalName": nameController.text,
                            "detail": detailController.text
                          };
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.lightGreen[400],
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: Text(
                                    'ยืนยันการเพิ่มการรักษา',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        'ยกเลิก',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    CupertinoDialogAction(
                                        child: Text(
                                          'ยืนยัน',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        onPressed: () {
                                          medicalApi.uploadData(
                                                  '${Constant().endPoint}/api/postMedicalData/${widget.getanimal.animalID}',
                                                  data)
                                              .then((value) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            // setState(() {

                                            // });
                                            final snackBar = SnackBar(
                                                content: Text(
                                                    'เพิ่มการรักษาเรียบร้อยแล้ว'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          });
                                        })
                                  ],
                                );
                              });
                        }
                      },
                      child: Text('เสร็จสิ้น',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          primary: HexColor('#697825')),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildfont(var title, var data) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget _heading(var title, double h, double w) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          color: HexColor("#697825"),
          borderRadius: BorderRadius.all(Radius.circular(45))),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

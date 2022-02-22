import 'dart:io';
import 'package:animal_welfare/screens/repair/successful.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../haxColor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:animal_welfare/constant.dart';


class RepairNotice extends StatefulWidget {
  const RepairNotice({Key? key}) : super(key: key);

  @override
  _RepairNoticeState createState() => _RepairNoticeState();
}

class _RepairNoticeState extends State<RepairNotice> {
  File? file; //dart.io
  final _formKey = GlobalKey<FormState>();
  TextEditingController repairController = TextEditingController();
  TextEditingController locationController = TextEditingController();
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
    request.headers.addAll(headers);//['authorization'] = data['Bearer $token'];
    var res = await request.send();
    print('${res.reasonPhrase}test');
    return res.reasonPhrase;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'แจ้งซ่อม',
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
                        'ปัญหาที่ชำรุด',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: repairController,

                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกปัญหาที่ชำรุด";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade800, width: 2))),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'สถานที่',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: locationController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกสถานที่";
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
                  Container(
                      height: 200,
                      width: double.infinity,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                         //   shape: StadiumBorder(),
                            side: BorderSide(
                                width: 2, color: Colors.green.shade800),
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
                            "maintenanceDetail": repairController.text,
                            "location": locationController.text,
                          };
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.lightGreen[400],
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: Text(
                                    'ยืนยันการแจ้งซ่อม',
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
                                          print('before upload image');
                                          uploadImageAndData(
                                              file!.path,
                                              '${Constant().endPoint}/api/postMaintenance',
                                              data).then((value) {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                            });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const RepairSuccessful()),
                                          );
                                        })                                  ],
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
                ],
              ),
            ),
          ),
        ),
      ),
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

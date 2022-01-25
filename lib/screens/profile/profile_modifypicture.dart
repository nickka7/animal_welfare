import 'dart:io';
import 'package:animal_welfare/screens/profile/profile_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/haxColor.dart';

class ModifyMyPicture extends StatefulWidget {
  const ModifyMyPicture({ Key? key }) : super(key: key);

  @override
  _ModifyMyPictureState createState() => _ModifyMyPictureState();
}

class _ModifyMyPictureState extends State<ModifyMyPicture> {
  File? file;
  final _formKey = GlobalKey<FormState>();
  TextEditingController repairController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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

    Future<String?> uploadImageAndData(filepath, url, data) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    request.fields['maintenanceDetail'] = data['maintenanceDetail'];
    request.fields['location'] = data['location'];
    var res = await request.send();
    print('${res.reasonPhrase}test');
    return res.reasonPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
        color: HexColor("#697825")
        ),
        ),
          centerTitle: true,
          title: Text('ข้อมูลส่วนตัว',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
    body: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(color: Colors.black45, blurRadius: 5)
                        ]),
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
                                        onPressed: () => Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyMainProfile()),
                                            ))
                                  ],
                                );
                              });
                          print(data);
                          // print('before upload data');
                          // postData('http://192.168.1.104:3000/api/postMaintenance', data);
                          print('before upload image');
                          uploadImageAndData(
                              file!.path,
                              'http://192.168.1.104:3000/api/postMaintenance',
                              data);
                        }
                      },
                      child: Text('เสร็จสิ้น',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                          primary: HexColor('#697825')),
                    ),
    ),
                  );
  }
}
import 'dart:io';

import 'package:animal_welfare/screens/repair/successful.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

import '../../../constant.dart';
import '../../../haxColor.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({Key? key}) : super(key: key);

  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  File? file; //dart.io
  final _formKey = GlobalKey<FormState>();
  TextEditingController repairController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final storage = new FlutterSecureStorage();

  Future<String?> uploadImageAndData(filepath, url, data) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'อัปโหลดเอกสาร',
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
                        'ชื่อเอกสาร',
                        style: TextStyle(fontSize: 18),
                      )),
                  TextFormField(
                    controller: locationController,
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        return "กรุณากรอกชื่อเอกสาร";
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
                  ElevatedButton(
                    onPressed: () async {
                      // FilePickerResult? result = await FilePicker.platform
                      //     .pickFiles();
                      //
                      // if (result != null) {
                      //   File file = File(result.files.single.path!);
                      //   // open(file);
                      // } else {
                      //   print('error');
                      // }
                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                      if (result != null) {
                        List<File> files = result.paths.map((path) => File(path!)).toList();
                        openFiles(files);
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Text('Upload File'),
                  ),
                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   child: OutlinedButton(
                  //       style: OutlinedButton.styleFrom(
                  //         shape: StadiumBorder(),
                  //         side: BorderSide(
                  //             width: 2, color: Colors.green.shade800),
                  //       ),
                  //       // color: Colors.green.shade800,
                  //       child: Center(
                  //         child: file == null
                  //             ? Icon(
                  //                 Icons.camera_alt_outlined,
                  //                 size: 40,
                  //               )
                  //             : Image.file(file!),
                  //       ),
                  //       onPressed: () => {}),
                  // ),
                  SizedBox(height: 40),
                  Container(
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
                                        onPressed: () {
                                          print('before upload image');
                                          uploadImageAndData(
                                              file!.path,
                                              '${Constant()
                                                  .endPoint}/api/postMaintenance',
                                              data);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const RepairSuccessful()),
                                          );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void open(File file) {
  //   OpenFile.open(file.path);
  // }

  Widget openFiles(List<File> files) =>
      GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemCount: files.length,
        itemBuilder: (context, index) {
          return Text('data');
        },);
}

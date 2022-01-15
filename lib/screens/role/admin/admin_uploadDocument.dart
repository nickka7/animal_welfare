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
  List<PlatformFile>? file; //dart.io
  final _formKey = GlobalKey<FormState>();
  TextEditingController repairController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final storage = new FlutterSecureStorage();

  // Future<String?> uploadImageAndData(filepath, url, data) async {
  //   String? token = await storage.read(key: 'token');
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(await http.MultipartFile.fromPath('image', filepath));
  //   request.fields['requestMessage'] = data['maintenanceDetail'];
  //   request.fields['location'] = data['location'];
  //   Map<String, String> headers = {
  //     "authorization": "Bearer $token",
  //   };
  //   request.headers
  //       .addAll(headers); //['authorization'] = data['Bearer $token'];
  //   var res = await request.send();
  //   print('${res.reasonPhrase}test');
  //   return res.reasonPhrase;
  // }

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
                    file == null ?
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

                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);

                      // print(result!.files);
                      if (result != null) {
                        // var a = result.files.first;
                        // print('testttttdeeeeett $a');

                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();

                        // print(files);
                        // print('Name: ${result.names}');
                        // print('Path: ${result.paths}');
                        // print('Name: ${result.names}');
                        // print('Name: ${result.names}');
                        print(result.files);


                        // openFiles(result.files);
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Text('Upload File'),
                  )
                  : openFiles(file!), //TODO:
                    SizedBox(height: 40),
                  // Container(
                  //   height: 50,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(5)),
                  //       boxShadow: [
                  //         BoxShadow(color: Colors.black45, blurRadius: 5)
                  //       ]),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       bool pass = _formKey.currentState!.validate();
                  //       if (pass) {
                  //         Map<String, String> data = {
                  //           "maintenanceDetail": repairController.text,
                  //           "location": locationController.text,
                  //         };
                  //         showDialog(
                  //             context: context,
                  //             builder: (context) {
                  //               return CupertinoAlertDialog(
                  //                 title: CircleAvatar(
                  //                   radius: 30,
                  //                   backgroundColor: Colors.lightGreen[400],
                  //                   child: Icon(
                  //                     Icons.check,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //                 content: Text(
                  //                   'ยืนยันการแจ้งซ่อม',
                  //                   style: TextStyle(fontSize: 16),
                  //                 ),
                  //                 actions: [
                  //                   CupertinoDialogAction(
                  //                     child: Text(
                  //                       'ยกเลิก',
                  //                       style: TextStyle(color: Colors.red),
                  //                     ),
                  //                     onPressed: () => Navigator.pop(context),
                  //                   ),
                  //                   CupertinoDialogAction(
                  //                       child: Text(
                  //                         'ยืนยัน',
                  //                         style: TextStyle(color: Colors.green),
                  //                       ),
                  //                       onPressed: () {
                  //                         print('before upload image');
                  //                         // uploadImageAndData(
                  //                         //     file!.path,
                  //                         //     '${Constant().endPoint}/api/postMaintenance',
                  //                         //     data);
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                               builder: (context) =>
                  //                                   const RepairSuccessful()),
                  //                         );
                  //                       })
                  //                 ],
                  //               );
                  //             });
                  //       }
                  //     },
                  //     child: Text('เสร็จสิ้น',
                  //         style: TextStyle(color: Colors.white, fontSize: 18)),
                  //     style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(25.0)),
                  //         primary: HexColor('#697825')),
                  //   ),
                  // ),
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

  Widget openFiles(List<PlatformFile> files) => Center(
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            // var color = files[index].extension;
            return buildFiles(file, openFile);
          },
        ),
      );

  Widget buildFiles(PlatformFile file, openFile) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${mb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    // final color = getColor(extension);
    return InkWell(
      onTap: openFile,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.amberAccent),
              child: Text(
                '.$extension',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            file.name,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          Text(
            fileSize,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}

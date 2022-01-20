import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

import '../../../constant.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({Key? key}) : super(key: key);

  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  Map<String, bool> values = {
    'ceo': false,
    'caretaker': false,
    'veterinarian': false,
    'researcher': false,
    'breeder': false,
    'showman': false,
  };

  List selected = [];

  // List<PlatformFile>? file;
  FilePickerResult? result;
  late List<String?> filePath;

  List getItems() {
    //โรลที่ถูกเลือก
    values.forEach((key, value) {
      if (value == true) {
        selected.add(key);
      }
    });
    print(selected);
    // selected.clear();
    // print(selected);

    return selected;
  }

  final storage = new FlutterSecureStorage();

  Future<String?> uploadDocAndRole({required List filePath, required String url, required List role}) async {
    print('1');
    // String? token = await storage.read(key: 'token');
    var request = http.MultipartRequest('POST', Uri.parse(url));

    for (int i = 0; i < filePath.length; i++) {
      // print('filePath.length: ${filePath.length}');
      request.files.add(await http.MultipartFile.fromPath('url', filePath[i]));
      print('${filePath[i]}');
      request.fields['documentName'] = getDocumentName(docPath: filePath[i]);
      // print('2');
      // print('role length: ${role.length}');
      for (int j = 0; j < role.length; j++) {
        // print('2.5');
        // print('role length: ${role.length}');
        request.fields['roleID'] = getRoleID(role[j])!;
        // print(getRoleID(role[i])!);
        // Map<String, String> headers = {
        //   "authorization":
        //       "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiJaMDAwMDAiLCJyb2xlSUQiOiJaMDAiLCJyb2xlIjoiYWRtaW4iLCJmaXJzdE5hbWUiOiLguKrguKHguJvguK3guIciLCJsYXN0TmFtZSI6IuC4i-C4seC4meC4iuC4suC4oiIsImlhdCI6MTY0MjUzMjMzNSwiZXhwIjoxNjQyNzA1MTM1fQ.ETkCjePHiVM4r8th_uLyX8Wo2FUa-HBX5GoidS-mYx0",
        // };
        // request.headers
        //     .addAll(headers); //['authorization'] = data['Bearer $token'];
        var res = await request.send();
        // print('${res.reasonPhrase} testtt');
        // print('3');
        // print(res.reasonPhrase);
        // return res.reasonPhrase;
      }
    }
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
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            result == null
                ? Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        // print(result!.files);
                        if (result != null) {
                          // var a = result.files.first;
                          // print('testttttdeeeeett $a');

                          // List<File> files = result!.paths
                          //     .map((path) => File(path!))
                          //     .toList();

                          // print(files);
                          // print('Name: ${result.names}');
                          print('Path: ${result!.paths}');
                          // print('Name: ${result.names}');
                          // print('Name: ${result.names}');
                          // print(result!.files);

                          // openFiles(result!.files);
                          setState(() {
                            filePath = result!.paths;
                            // print(filePath);
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Text('Upload File'),
                    ),
                  )
                : openFiles(result!.files),
            SizedBox(height: 15),
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: values.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key),
                  value: values[key],
                  onChanged: (bool? value) {
                    setState(() {
                      values[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  getItems();
                  // for (int i = 0; i < filePath.length; i++) {}
                  uploadDocAndRole(
                    filePath: result!.paths,
                    url: '${Constant().endPoint}/api/postDocument',
                    role: selected,
                  );
                },
                child: Text('อัปโหลด'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget openFiles(List<PlatformFile> files) => GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          // var color = files[index].extension;
          return buildFiles(file);
        },
      );

  Widget buildFiles(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${mb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    final color = getColor(extension);
    return InkWell(
      onTap: () => openFile(file),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(25)),
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

  MaterialColor? getColor(String extension) {
    switch (extension) {
      case 'xlsx':
        {
          return Colors.amber;
        }

      case 'pdf':
        {
          return Colors.blue;
        }

      case 'docx':
        {
          return Colors.orange;
        }
      default:
        {
          return Colors.grey;
        }
    }
  }

  String? getRoleID(role) {
    switch (role) {
      case 'ceo':
        {
          return 'Z01';
        }
      case 'caretaker':
        {
          return 'Z02';
        }
      case 'veterinarian':
        {
          return 'Z03';
        }
      case 'researcher':
        {
          return 'Z04';
        }
      case 'breeder':
        {
          return 'Z05';
        }
      case 'showman':
        {
          return 'Z06';
        }
    }
  }

  String getDocumentName({required String docPath}) {
    return docPath.split('/').last;
  }

  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (context) => DocumentPage(
  //       files: files,
  //       onOpenedFile: openFile,
  //     ),
  //   ),
  // );

  // Widget buildFiles(PlatformFile file, openFile) {
  //   final kb = file.size / 1024;
  //   final mb = kb / 1024;
  //   final fileSize =
  //       mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${mb.toStringAsFixed(2)} KB';
  //   final extension = file.extension ?? 'none';
  //   // final color = getColor(extension);
  //   return InkWell(
  //     onTap: openFile,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           child: Container(
  //             alignment: Alignment.center,
  //             width: double.infinity,
  //             decoration: BoxDecoration(color: Colors.amberAccent),
  //             child: Text(
  //               '.$extension',
  //               style: TextStyle(
  //                   fontSize: 28,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           file.name,
  //           style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               overflow: TextOverflow.ellipsis),
  //         ),
  //         Text(
  //           fileSize,
  //           style: TextStyle(fontSize: 16),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}

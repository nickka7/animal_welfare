import 'package:animal_welfare/api/research.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import '../../../constant.dart';

class ResearchUploadDocument extends StatefulWidget {
  const ResearchUploadDocument({Key? key}) : super(key: key);

  @override
  _ResearchUploadDocumentState createState() => _ResearchUploadDocumentState();
}

class _ResearchUploadDocumentState extends State<ResearchUploadDocument> {
  final ResearchApi researchApi = ResearchApi();

  FilePickerResult? result;
  late List<String?> filePath;

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
          child: FutureBuilder<bool>(
        future: researchApi.getlistOfResearch(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                              print('Path: ${result!.paths}');
                              setState(() {
                                filePath = result!.paths;
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
                  primary: false,
                  // scrollDirection: Axis.vertical,
                  children: researchApi.map.keys.map((String key) {
                    return new CheckboxListTile(
                      title: new Text(key),
                      value: researchApi.map[key],
                      onChanged: (bool? value) {
                        setState(() {
                          researchApi.map[key] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          primary: HexColor('#697825')),
                      child: Text('อัปโหลด',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500)),
                      onPressed: () {
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
                                  'ยืนยันการอัปโหลดเอกสาร',
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
                                        researchApi.getItems();
                                        // for (int i = 0; i < filePath.length; i++) {}
                                        researchApi.uploadDocAndUser(
                                          filePath: result!.paths,
                                          url:
                                              '${Constant().endPoint}/api/postResearchDocument',
                                          Emp: researchApi.selected,
                                        );
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        final snackBar = SnackBar(
                                            content: Text(
                                                'อัปโหลดเอกสารเรียบร้อยแล้ว'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      })
                                ],
                              );
                            });
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  Widget openFiles(List<PlatformFile> files) => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
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

  String getDocumentName({required String docPath}) {
    return docPath.split('/').last;
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}

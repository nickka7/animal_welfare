import 'dart:convert';
import 'dart:io';
import 'package:animal_welfare/screens/logout/setting_logout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/model/document.dart';
import '../../../constant.dart';

class AdminDownloadFile extends StatefulWidget {
  const AdminDownloadFile({Key? key}) : super(key: key);

  @override
  _AdminDownloadFileState createState() => _AdminDownloadFileState();
}

class _AdminDownloadFileState extends State<AdminDownloadFile> {
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  Future<Document> getDocument() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getDocumentAdmin'),
        headers: {"authorization": 'Bearer $token'});
    var jsonData = Document.fromJson(jsonDecode(response.body));
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('เอกสาร'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getDocument(),
            builder: (BuildContext context, AsyncSnapshot<Document> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.document_scanner_outlined),
                        title:
                            Text('${snapshot.data!.data![index].documentName}'),
                        onTap: () => openFile(
                          url: '${snapshot.data!.data![index].url}',
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      Text('กรุณารอสักครู่'),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String? name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}

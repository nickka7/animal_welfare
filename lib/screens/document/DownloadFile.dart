import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);

  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เอกสาร'),
        centerTitle: true,
      ),
      body:  Card(
            child: ListTile(
              leading: Icon(Icons.document_scanner_outlined),
              title: Text("เอกสาร"),
               onTap: () => openFile(
                  
              // '', url: 'https://www.ocsc.go.th/sites/default/files/document/example_calculation25552.xls',
                url: 'http://tls.labour.go.th/attachments/category/118/0000001%20tls%2003%202563.doc',
                // https://shortrecap.co/wp-content/uploads/2020/05/Catcover_web.jpg
               // url: 'http://www.pdf995.com/samples/pdf.pdf',
               //  '',
               // url:'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4'
                //   'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4',
                 fileName: 'abc.doc',
              ),
            ),
          ) 
    );
  }

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ??
        url //ถ้าไม่มี filename ให้ข้ามไป
            .split('/')
            .last;
    final file = await downloadFile(url, name);
    if (file == null) return;
    print('Path: ${file.path}');
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

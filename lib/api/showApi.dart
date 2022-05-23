import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

class ShowApi {
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;
  List shows = [];
  //แสดงรายชื่อการแสดง
  Future<bool> getShowType() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getAllShowType'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData2 = json.decode(response.body)['data'];
    for (int i = 0; i < jsonData2.length; i++) {
      shows.add(jsonData2[i]['showName']);
    }
    // shows.insert(0,'กรุณาเลือกโชว์');
    print(shows);
    return true;
  }

//เพิ่มรอบการแสดง
  Future<String?> uploadData(url, data) async {
    // print(file!.path);
    String? token = await storage.read(key: 'token');
    // ignore: unused_local_variable
    var request = http.post(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          'showName': data['showName'],
          'startDate': data['startDate'],
          'endDate': data['endDate'],
        }));
  }

//แก้ไขรอบการแสดง
    Future<String?> updateData(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.put(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          // 'userID' : data['userID'],
          'showName': data['showName'],
          'startDate': data['startDate'],
          'endDate': data['endDate'],
        }));
    print(data['scheduleName']);
    print(request);
  }
}

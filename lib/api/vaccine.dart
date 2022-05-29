import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

class VaccineApi {
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;
  List vaccineID = [];

  Future<bool> getVaccine() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getVaccineUsable'),
        headers: {"authorization": 'Bearer $token'});
    //print('response.body ${response.body}');

    List jsonData = json.decode(response.body)['data'];
    if (jsonData.length != 0) {
      for (int i = 0; i < jsonData.length; i++) {
        vaccineID.add(
            '${jsonData[i]['vaccineID']} ${jsonData[i]['vaccineName'] ?? 'ไม่มี'} ');
      }
      print(vaccineID);
    } else {
      vaccineID.add('ไม่มีวัคซีน');
    }
    print(' ${vaccineID}');
    //print(vaccineName);
    return true;
  }

//เพิ่มการฉีดวัคซีน
  Future<String?> uploadData(url, data) async {
    print(data['vaccineID']);
    String? token = await storage.read(key: 'token');
    var request = http.post(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          // "Content-Type": "application/x-www-form-urlencoded",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'vaccineID': data['vaccineID'],
        }));
  }

//แก้ไขการฉีดวัคซีน
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
          'vaccineID': data['vaccineID'],
        }));

    print(request);
  }

}

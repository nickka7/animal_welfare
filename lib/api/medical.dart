import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

class MedicalApi{
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  Future<String?> uploadData(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.post(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          'medicalName': data['medicalName'],
          'detail': data['detail'],
        }));

    print(request);
    print(data['medicalName']);
    print(data['detail']);
    // print(data['endDate']);
  }


  Future<String?> updateData(url, data) async {
    String? token = await storage.read(key: 'token');
    var request = http.put(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          'medicalName': data['medicalName'],
          'detail': data['detail'],
        }));
    print(data['scheduleName']);
    print(' ${request}');
  }

  
}
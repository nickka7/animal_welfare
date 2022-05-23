import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

class ResearchApi {
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  List selected = [];

  List getItems() {
    //พนักงานที่ถูกเลือก
    map.forEach((key, value) {
      if (value == true) {
        selected.add(key);
      }
    });
    print(selected);
    return selected;
  }

  Future<String?> uploadDocAndUser(
      {required List filePath, required String url, required List Emp}) async {
    String? token = await storage.read(key: 'token');
    print('1');
    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> headers = {
      "authorization": "Bearer $token",
    };
    for (int i = 0; i < filePath.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('url', filePath[i]));
    }
    for (int j = 0; j < Emp.length; j++) {
      request.fields['userID[$j]'] = '${Emp[j].split(" ")[0]}';
    }
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
  }

  final listOfResearch = [];
  late final map = Map<String, bool>.fromIterable(listOfResearch,
      key: (item) => item.toString(), value: (item) => false);

  Future<bool> getlistOfResearch() async {
    final storage = new FlutterSecureStorage();
    String endPoint = Constant().endPoint;
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/friendResearcher'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    List jsonData = json.decode(response.body)['message'];

    for (int i = 0; i < jsonData.length; i++) {
      listOfResearch
          .add('${jsonData[i]['userID']} ${jsonData[i]['firstName']} ');
    }

    print(map);

    return true;
  }
}

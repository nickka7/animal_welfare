import 'dart:convert';

import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/news.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class News{
 static Future<NewsData> getNews() async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getNews/0'),
        headers: {"authorization": 'Bearer $token'});
    
    // print(response.body);
    var jsonData = NewsData.fromJson(jsonDecode(response.body));
    // print(jsonData);
    return jsonData;
  }
}
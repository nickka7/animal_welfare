import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import '../model/weather.dart';

class Weather {
  Future<WeatherData> getWeather() async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getWeather'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = WeatherData.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }
}

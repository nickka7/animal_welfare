import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/model/hotNews.dart';

import '../model/hotNews.dart';

class HotNewsApi {
  
  static Future<List<ImageList>> getimage() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=1'));

    if (response.statusCode == 200) {
      final List image = json.decode(response.body);
      if(image.length >= 5) {
      image.length = 5;
    }
      return image.map((m) => new ImageList.fromJson(m)).toList();
    } else {
      throw Exception('error ');
    }
  }
}

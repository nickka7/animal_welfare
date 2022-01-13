import 'dart:convert';

import 'package:animal_welfare/model/research.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class ResearchApi {
  static Future<List<Data>> getResearch(String query) async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;

    final url = Uri.parse('$endPoint/api/getResearchData');

    final response =
        await http.get(url, headers: {"authorization": 'Bearer $token'});
    //print('1');

    if (response.statusCode == 200) {
      //  print('2');

      final researchs = json.decode(response.body);
      final List data = researchs['data'];
      // print('3');
      // print('test $bio');
      return data.map((json) => Data.fromJson(json)).where((research) {
        final researchIDLower = research.researchID;
        print(researchIDLower);
        final typeNameLower = research.typeName!;
        print(typeNameLower);
        final researchNameLower = research.researchName!;
        print(researchNameLower);
        final researchdateLower = research.date!;
        print(researchdateLower);
        final searchLower = query;
        print(searchLower);
        // print(animalTypeLower.contains(searchLower));
        return researchIDLower!.contains(searchLower) ||
            typeNameLower.contains(searchLower) ||
            researchNameLower.contains(searchLower) ||
            researchdateLower.contains(searchLower);
      }).toList();
    } else {
      print('not 200');
      throw Exception();
    }
  }
}

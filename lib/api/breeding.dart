import 'dart:convert';

import 'package:animal_welfare/model/breeding.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class BreedingApi {
  static Future<List<Data>> getResearch(String query) async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;

    final url = Uri.parse('$endPoint/api/getBreedingData');

    final response =
        await http.get(url, headers: {"authorization": 'Bearer $token'});
    //print('1');

    if (response.statusCode == 200) {
      //  print('2');

      final breeding = json.decode(response.body);
      final List data = breeding['data'];
      // print('3');
      // print('test $bio');
      return data.map((json) => Data.fromJson(json)).where((breeding) {
        final breedingIDLower = breeding.breedingID;
        print(breedingIDLower);
        final typeNameLower = breeding.typeName;
        print(typeNameLower);
        final breedingNameLower = breeding.breedingName;
        print(breedingNameLower);
        final researchdateLower = breeding.date;
        print(researchdateLower);
        final searchLower = query;
        print(searchLower);
        // print(animalTypeLower.contains(searchLower));
        return breedingIDLower.contains(searchLower) ||
            typeNameLower.contains(searchLower) ||
            breedingNameLower.contains(searchLower) ||
            researchdateLower.contains(searchLower);
      }).toList();
    } else {
      print('not 200');
      throw Exception();
    }
  }
}

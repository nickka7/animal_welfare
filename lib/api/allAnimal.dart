import 'dart:convert';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class AllAnimalsAPI {
  static Future<List<Bio>> getAllAnimals(String query) async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;

    final url = Uri.parse('$endPoint/api/getAnimalInZoo');

    final response =
        await http.get(url, headers: {"authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      final allanimals = json.decode(response.body);
      final List bio = allanimals['bio'];
      return bio.map((json) => Bio.fromJson(json)).where((animal) {
        final animalTypeLower = animal.typeName!;
        print(animalTypeLower);
        final animalNameLower = animal.animalName!;
        print(animalNameLower);
        final searchLower = query;
        print(searchLower);
        // print(animalTypeLower.contains(searchLower));
        return animalTypeLower.contains(searchLower) ||
            animalNameLower.contains(searchLower);
      }).toList();
    } else {
      print('not 200');
      throw Exception();
    }
  }
}

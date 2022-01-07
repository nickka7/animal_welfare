import 'dart:convert';
import 'package:animal_welfare/model/all_animals.dart.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class AllAnimalsAPI {
  static Future<List<Bio>> getAllAnimals(String query) async {
    String endPoint = Constant().endPoint;
    final url = Uri.parse(
        '$endPoint/api/getAnimalInZoo');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final allanimals = json.decode(response.body);
      final List bio = allanimals['bio'];

      return bio.map((json) => Bio.fromJson(json)).where((animal) {
        final animalTypeLower = animal.typeName!.toLowerCase();
        final animalNameLower = animal.animalName!.toLowerCase();
        final searchLower = query;

        return animalTypeLower!.contains(searchLower) ||
            animalNameLower!.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}


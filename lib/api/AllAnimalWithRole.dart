import 'dart:convert';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class AllAnimalsWithRoleAPI {
  static Future<List<Bio>> getAllAnimalsWithRole(String query) async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;

    final url = Uri.parse('$endPoint/api/getAnimalWithRole');

    final response =
        await http.get(url, headers: {"authorization": 'Bearer $token'});
    print('1');

    if (response.statusCode == 200) {
      print('2');

      final allanimals = json.decode(response.body);
      final List bio = allanimals['bio'];
      print('3');
      print('test $bio');
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

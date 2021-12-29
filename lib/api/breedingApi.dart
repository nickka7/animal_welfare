import 'dart:convert';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/book.dart';
import 'package:animal_welfare/model/breeding.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class BreedingApi {
  final storage = new FlutterSecureStorage();

    Future<List<Data>> getBreeding(String query) async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getBreedingData'),
        headers: {"authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((json) => Data.fromJson(json)).where((breeding) {
        final breedingNameLower = breeding.breedingName!.toLowerCase();
        final typeNameLower = breeding.typeName!.toLowerCase();
        final searchLower = query.toLowerCase();

        return breedingNameLower.contains(searchLower) ||
            typeNameLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
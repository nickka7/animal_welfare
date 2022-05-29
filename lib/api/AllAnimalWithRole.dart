import 'dart:convert';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class AllAnimalsWithRoleAPI {
    String endPoint = Constant().endPoint;
  final storage = new FlutterSecureStorage();

//ค้นหาสัตว์ทั้งหมด
  static Future<List<Bio>> getAllAnimalsWithRole(String query) async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;

    final url = Uri.parse('$endPoint/api/getAnimalWithRole');

    final response =
        await http.get(url, headers: {"authorization": 'Bearer $token'});
   // print('1');

    if (response.statusCode == 200) {
    //  print('2');

      final allanimals = json.decode(response.body);
      final List bio = allanimals['bio'];
    //  print('3');
      print('test $bio');
      return bio.map((json) => Bio.fromJson(json)).where((animal) {
        final animalIDLower = animal.animalID!;
        final animalTypeLower = animal.typeName!;
        print(animalTypeLower);
        final animalNameLower = animal.animalName!;
        print(animalNameLower);
        final searchLower = query;
        print(searchLower);
        // print(animalTypeLower.contains(searchLower));
        return animalIDLower.contains(searchLower) || animalTypeLower.contains(searchLower) ||
            animalNameLower.contains(searchLower);
      }).toList();
    } else {
      print('not 200');
      throw Exception();
    }
  }
//จำนวนสัตว์แต่ละชนิด
    Future<AllAnimalsWithRole> getNumAnimalWithRole() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getAnimalWithRole'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = AllAnimalsWithRole.fromJson(jsonDecode(response.body));
    print('$jsonData');
    return jsonData;
  }

  List animal = [];
//listของรหัสสัตว์ ชื่อสัตว์
  Future<bool> getAnimal() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('$endPoint/api/getUsableAddAnimalUserID'),
        headers: {"authorization": 'Bearer $token'});
    // print('response.body ${response.body}');

    // List jsonData = json.decode(response.body)['data'];
    final allanimals = json.decode(response.body);
    final List bio = allanimals['bio'];

    for (int i = 0; i < bio.length; i++) {
      animal.add(
          '${bio[i]['animalID']} ${bio[i]['animalName']} ${bio[i]['typeName']}');
    }
    print(animal);

    return true;
  }

//เพิ่มสัตว์ภายใต้การดูแล
    Future<String?> uploadData(url, data) async {
    // print(file!.path);
    String? token = await storage.read(key: 'token');
    var request = http.post(Uri.parse(url),
        headers: <String, String>{
          "authorization": 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //   headers: {"authorization": 'Bearer $token'},
        body: jsonEncode(<String, String>{
          'animalID': data['animalID'],
        }));

    print(request);
  }
}

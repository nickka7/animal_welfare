import 'dart:convert';
import 'package:animal_welfare/model/login.dart';
import 'package:http/http.dart' as http;

// class LoginApi {
//
//   static Future<Logindata> getLogin(String username,String password) async {
//     Uri url = Uri.parse('localhost:3000/api/login');
//     http.Response response = await http.post(url, body: {
//       "userID": username,
//       "password": password,
//     });
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//    //   print("Response status: ${response.body}");
//       return Logindata.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('failed');
//     }
//   }
// }

class LoginApi {
  LoginApi();

  String endPoint = 'http://192.168.1.103:3000';

  Future<http.Response> doLogin(String userID, String password) async {
    String _url = '$endPoint/api/login';
    var body = {"userID": userID, "password": password};
    return http.post(Uri.parse(_url), body: body);
  }
}

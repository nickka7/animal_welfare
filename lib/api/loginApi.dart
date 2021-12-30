
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';

class LoginApi {
  LoginApi();
  String endPoints = Constant().endPoint;

  Future<http.Response> doLogin(String userID, String password) async {
    String _url = '$endPoints/api/login';
    var body = {"userID": userID, "password": password};
    return http.post(Uri.parse(_url), body: body);
  }
}

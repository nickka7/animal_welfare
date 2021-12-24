import 'dart:convert';
import 'package:animal_welfare/model/calendar.dart';
import 'package:http/http.dart' as http;

class CalendarApi {
  static Future<CalendarData> getCalendar() async {
    Uri url = Uri.parse(
        'localhost:3000/api/calendar');
    http.Response response = await http.get(url, headers: {
 //     "authorization": "Bearer {$CalendarData.token}",
    });
   
       if (response.statusCode == 200) {
      print("Response status: ${response.body}");
      return CalendarData.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed');
    }
  }
}

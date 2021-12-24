import 'dart:convert';
import 'package:animal_welfare/model/calendar.dart';
import 'package:http/http.dart' as http;

class CalendarApi {
  static Future<CalendarData> getCalendar() async {
    final response = await http.get(Uri.parse('localhost:3000/api/calendar'));

       if (response.statusCode == 200) {
      print("Response status: ${response.body}");
      return CalendarData.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed');
    }
  }
}

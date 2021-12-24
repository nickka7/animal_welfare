import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:animal_welfare/model/movie.dart';

class MovieApi {

  static Future<MovieData> getMovie() async {
    Uri url = Uri.parse(
        'https://movie-database-imdb-alternative.p.rapidapi.com/?s=aquaman&page=1&r=json');
    http.Response response = await http.get(url, headers: {
      "x-rapidapi-key": "8995a8cc8cmshe10cb8d52233a86p11c409jsn27b93c7616c2",
      "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com",
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
   //   print("Response status: ${response.body}");
      return MovieData.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed');
    }
  }
}

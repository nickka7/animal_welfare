class MovieData {
  late List<Search> search;
  late String totalResults;
  late String response;

  MovieData(
      {required this.search,
      required this.totalResults,
      required this.response});

  MovieData.fromJson(Map<String, dynamic> json) {
    if (json["Search"] is List)
      this.search = (json["Search"] == null
          ? null
          : (json["Search"] as List).map((e) => Search.fromJson(e)).toList())!;
    if (json["totalResults"] is String)
      this.totalResults = json["totalResults"];
    if (json["Response"] is String) this.response = json["Response"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // ignore: unnecessary_null_comparison
    if (this.search != null)
    data["Search"] = this.search.map((e) => e.toJson()).toList();
    data["totalResults"] = this.totalResults;
    data["Response"] = this.response;
    return data;
  }
}

class Search {
  late String title;
  late String year;
  late String imdbId;
  late String type;
  late String poster;

  Search(
      {required this.title,
      required this.year,
      required this.imdbId,
      required this.type,
      required this.poster});

  Search.fromJson(Map<String, dynamic> json) {
    if (json["Title"] is String) this.title = json["Title"];
    if (json["Year"] is String) this.year = json["Year"];
    if (json["imdbID"] is String) this.imdbId = json["imdbID"];
    if (json["Type"] is String) this.type = json["Type"];
    if (json["Poster"] is String) this.poster = json["Poster"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Title"] = this.title;
    data["Year"] = this.year;
    data["imdbID"] = this.imdbId;
    data["Type"] = this.type;
    data["Poster"] = this.poster;
    return data;
  }
}

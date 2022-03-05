// To parse this JSON data, do
//
//     final animalReport = animalReportFromJson(jsonString);

import 'dart:convert';

List<AnimalReport> animalReportFromJson(String str) => List<AnimalReport>.from(json.decode(str).map((x) => AnimalReport.fromJson(x)));

String animalReportToJson(List<AnimalReport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnimalReport {
    AnimalReport({
        required this.typename,
        required this.percent,
    });

    String typename;
    double percent;

    factory AnimalReport.fromJson(Map<String, dynamic> json) => AnimalReport(
        typename: json["typename"] == null ? null : json["typename"],
        percent: json["percent"] == null ? null : json["percent"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "typename": typename == null ? null : typename,
        "percent": percent == null ? null : percent,
    };
}

// To parse this JSON data, do
//
//     final newsData = newsDataFromJson(jsonString);

import 'dart:convert';

NewsData newsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

String newsDataToJson(NewsData data) => json.encode(data.toJson());

class NewsData {
    NewsData({
        required this.resultCode,
        required this.status,
        required this.errorMessage,
        required this.data,
    });

    String resultCode;
    String status;
    dynamic errorMessage;
    List<Datum> data;

    factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        resultCode: json["resultCode"] == null ? null : json["resultCode"],
        status: json["status"] == null ? null : json["status"],
        errorMessage: json["errorMessage"],
        data: json["data"] ,
    );

    Map<String, dynamic> toJson() => {
        "resultCode": resultCode == null ? null : resultCode,
        "status": status == null ? null : status,
        "errorMessage": errorMessage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
      required this.title,
      required this.detail,
      required this.image,
    });

    String title;
    String detail;
    String image;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"] == null ? null : json["title"],
        detail: json["detail"] == null ? null : json["detail"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "detail": detail == null ? null : detail,
        "image": image == null ? null : image,
    };
}

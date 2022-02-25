// To parse this JSON data, do
//
//     final showType = showTypeFromJson(jsonString);

import 'dart:convert';

ShowType showTypeFromJson(String str) => ShowType.fromJson(json.decode(str));

String showTypeToJson(ShowType data) => json.encode(data.toJson());

class ShowType {
    ShowType({
        required this.resultCode,
        required this.status,
        this.errorMessage,
        required this.data,
    });

    String resultCode;
    String status;
    dynamic errorMessage;
    List<Datum> data;

    factory ShowType.fromJson(Map<String, dynamic> json) => ShowType(
        resultCode: json["resultCode"] == null ? null : json["resultCode"],
        status: json["status"] == null ? null : json["status"],
        errorMessage: json["errorMessage"],
        data: json["data"] == null ? null : json["data"],
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
        required this.showName,
    });

    String showName;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        showName: json["showName"] == null ? null : json["showName"],
    );

    Map<String, dynamic> toJson() => {
        "showName": showName == null ? null : showName,
    };
}

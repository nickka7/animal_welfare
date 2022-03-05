// To parse this JSON data, do
//
//     final vaccine = vaccineFromJson(jsonString);

import 'dart:convert';

Vaccine vaccineFromJson(String str) => Vaccine.fromJson(json.decode(str));

String vaccineToJson(Vaccine data) => json.encode(data.toJson());

class Vaccine {
    Vaccine({
        required this.resultCode,
        required this.status,
        this.errorMessage,
        required this.data,
    });

    String resultCode;
    String status;
    dynamic errorMessage;
    List<Datum> data;

    factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
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
        required this.vaccineId,
        required this.vaccineName,
    });

    String vaccineId;
    String vaccineName;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        vaccineId: json["vaccineID"] == null ? null : json["vaccineID"],
        vaccineName: json["vaccineName"] == null ? null : json["vaccineName"],
    );

    Map<String, dynamic> toJson() => {
        "vaccineID": vaccineId == null ? null : vaccineId,
        "vaccineName": vaccineName == null ? null : vaccineName,
    };
}

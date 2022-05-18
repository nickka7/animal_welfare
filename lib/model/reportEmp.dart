import 'dart:convert';

List<EmpReport> empReportFromJson(String str) => List<EmpReport>.from(json.decode(str).map((x) => EmpReport.fromJson(x)));

String empReportToJson(List<EmpReport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmpReport {
    EmpReport({
        required this.percent,
        required this.nameTh,
    });

    double percent;
    String nameTh;

    factory EmpReport.fromJson(Map<String, dynamic> json) => EmpReport(
        percent: json["Percent"].toDouble(),
        nameTh: json["nameTH"],
    );

    Map<String, dynamic> toJson() => {
        "Percent": percent,
        "nameTH": nameTh,
    };
}

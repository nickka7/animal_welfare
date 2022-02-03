import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/barCharts.dart';
import 'package:animal_welfare/model/report_animal.dart';
import 'package:animal_welfare/screens/role/Executive/animalReport.dart';
import 'package:animal_welfare/screens/role/Executive/report.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SimpleBarChart extends StatefulWidget {
  final GetReportAnimal report;
  const SimpleBarChart({Key? key, required this.report}) : super(key: key);

  @override
  State<SimpleBarChart> createState() => _SimpleBarChartState();
}

final storage = new FlutterSecureStorage();

 
   List<charts.Series<Total, String>> _createData() {
    final data = [
      Total('typeName', 29),
      Total('เสือ', 50),
      Total('ยีราฟ', 88),
    ];
    return [
      charts.Series<Total, String>(
        data: data,
        id: 'sale',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Total barModel, _) => barModel.typeName.toString(),
        measureFn: (Total barModel, _) => barModel.total,
      )
    ];
  }


class _SimpleBarChartState extends State<SimpleBarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 350,
      child: Text('${widget.report.total![0].typeName}')
    );
  }
}

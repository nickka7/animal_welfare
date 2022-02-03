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
 
   List<charts.Series<BarCharts, String>> _createData() {
    final data = [
      BarCharts('ช้าง', 29),
      BarCharts('เสือ', 50),
      BarCharts('ยีราฟ', 88),
    ];
    return [
      charts.Series<BarCharts, String>(
        data: data,
        id: 'sale',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (BarCharts barModel, _) => barModel.animalType,
        measureFn: (BarCharts barModel, _) => barModel.total,
      )
    ];
  }


class _SimpleBarChartState extends State<SimpleBarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 350,
      child: charts.BarChart(
        _createData(),
        animate: true,
      ),
    );
  }
}

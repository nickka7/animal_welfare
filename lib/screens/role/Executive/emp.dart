import 'dart:convert';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/reportAnimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../model/reportEmp.dart';

class ReportTest extends StatefulWidget {
  const ReportTest({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<ReportTest> {
  late FixedExtentScrollController scrollController;

  Future<void>? api;
  int index = 0;
 
  @override
  void initState() {
    super.initState();
    
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    scrollController.dispose();
    super.dispose();
  }

  // DateTime _Date = DateTime.now();
  int indexY = 0;
  int indexM = 0;


  final year = ['2021', '2022'];
  final month = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];


  final storage = new FlutterSecureStorage();

  List<EmpReport> report = [];

  Future<EmpReport> getEmpReport() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(
      Uri.parse(
          '$endPoint/api/employeeReport?month=${month[indexM]}&year=${year[indexY]}'),
      headers: {"authorization": 'Bearer $token'},
    );

    //print(response.body);
    var jsonData = jsonDecode(response.body);

    List<EmpReport> tempdata = empReportFromJson(response.body);
    setState(() {
      report = tempdata ;
    });
    print('$jsonData');
    return jsonData;
  }

  List<charts.Series<EmpReport, String>> _createSampleData() {
    return [
      charts.Series<EmpReport, String>(
        data: report,
        id: 'nameTH',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (EmpReport genderModel, _) => genderModel.nameTh,
        measureFn: (EmpReport genderModel, _) => genderModel.percent,
        
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'รายงานการเข้างาน',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 58,
                    width: 180,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.black45),
                        ),
                        onPressed: () {
                          scrollController.dispose();
                          scrollController =
                              FixedExtentScrollController(initialItem: indexM);
                          _monthPicker(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              month[indexM],
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            )
                          ],
                        )),
                  ),
                  Container(
                    height: 58,
                    width: 180,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.black45),
                        ),
                        onPressed: () {
                          scrollController.dispose();
                          scrollController =
                              FixedExtentScrollController(initialItem: indexY);
                          _yearPicker(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              year[indexY],
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            
              SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    getEmpReport();
                  },
                  child: Text('ค้นหา',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      primary: HexColor('#697825')),
                ),
              ),
              SizedBox(height: 40),
              //กราฟ
              SizedBox(height: 10),

              charts1()
            ],
          ),
        ),
      ),
    );
  }

  void _yearPicker(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 30,
                  scrollController: scrollController,
                  children: year
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.indexY = index;
                      final item = year[index];
                      print('selected $item');
                    });
                  },
                  diameterRatio: 1,
                  useMagnifier: true,
                  magnification: 1.3,
                ),
              ),
              CupertinoButton(
                child: Text('ยืนยัน'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _monthPicker(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 30,
                  scrollController: scrollController,
                  children: month
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.indexM = index;
                      final item = month[index];
                      print('selected $item');
                    });
                  },
                  diameterRatio: 1,
                  useMagnifier: true,
                  magnification: 1.3,
                ),
              ),
              CupertinoButton(
                child: Text('ยืนยัน'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  
  Widget charts1() {
    if (report.isNotEmpty) {
      return Column(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Text('แผนภูมิแสดงเปอร์เซ็นการเข้างาน')),
          Container(
            height: 300,
            width: 380,
            child: charts.BarChart(
              _createSampleData(),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelRotation: 45)
              ),
              animate: true,
            ),
          ),
        ],
      );
    } else
      return Text(" ");
  }
}

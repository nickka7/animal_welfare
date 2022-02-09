import 'dart:convert';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/reportAnimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnimalReportTest extends StatefulWidget {
  const AnimalReportTest({Key? key}) : super(key: key);

  @override
  _AnimalReportState createState() => _AnimalReportState();
}

class _AnimalReportState extends State<AnimalReportTest> {
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController vaccineController = TextEditingController();

  // DateTime _Date = DateTime.now();
  int indexY = 0;
  int indexM = 0;
  int indexV = 0;

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
  final vaccine = ['บาดทะยัก', 'พิษสุนัขบ้า'];

  final storage = new FlutterSecureStorage();

  List<AnimalReport> report = [];

  Future<AnimalReport> getAnimalReport() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(
      Uri.parse(
          '$endPoint/api/getReport?year=${year[indexY]}&month=${month[indexM]}&vaccineType=${vaccine[indexV]}'),
      headers: {"authorization": 'Bearer $token'},
    );

    //print(response.body);
    var jsonData = jsonDecode(response.body);

    List<AnimalReport> tempdata = animalReportFromJson(response.body);
    setState(() {
      report = tempdata;
    });
    print('$jsonData');
    return jsonData;
  }

  List<charts.Series<AnimalReport, String>> _createSampleData() {
    return [
      charts.Series<AnimalReport, String>(
        data: report,
        id: 'sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (AnimalReport genderModel, _) => genderModel.typename,
        measureFn: (AnimalReport genderModel, _) => genderModel.percent,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'รายงานการฉีดวัคซีน',
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
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 58,
                  width: double.infinity,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1, color: Colors.black45),
                      ),
                      onPressed: () {
                        _vaccinePicker(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vaccine[indexV],
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    getAnimalReport();
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
              Align(
                  alignment: Alignment.topCenter,
                  child: Text('แผนภูมิแสดงเปอร์เซ็นการฉีดวัคซีน')),
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: year
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (indexY) {
                    setState(() {
                      this.indexY = indexY;
                      final item = year[indexY];
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: month
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (indexM) {
                    setState(() {
                      this.indexM = indexM;
                      final item = month[indexM];
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

  void _vaccinePicker(context) {
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
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: vaccine
                      .map((item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onSelectedItemChanged: (indexV) {
                    setState(() {
                      this.indexV = indexV;
                      final item = vaccine[indexV];
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
      return Container(
        height: 300,
        width: 300,
        child: charts.BarChart(
          _createSampleData(),
          animate: true,


        ),
      );
    } else
      return Text("");
  }
}

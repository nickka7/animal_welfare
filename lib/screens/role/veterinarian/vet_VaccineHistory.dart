import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';

class VetVaccineHistory extends StatefulWidget {
  const VetVaccineHistory({Key? key}) : super(key: key);

  @override
  _VetVaccineHistoryState createState() => _VetVaccineHistoryState();
}

class _VetVaccineHistoryState extends State<VetVaccineHistory> {
  DateTime _date = DateTime.now();

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 400,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  // Close the modal
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff999999),
                          width: 0.0,
                        ),
                      ),
                    ),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(width: 30,),
                        CupertinoButton(
                          child: Text('ยืนยัน'),
                          onPressed: () => Navigator.of(ctx).pop(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 5.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  Container(
                    height: 300,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        maximumYear: DateTime.now().year,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _date = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }

  final List<Map<String, dynamic>> _allAnimals = [
    {"Medical": "ถ่ายพยาธิ", "time": "9.00-10.00", "date": "10 ตุลาคม 2564 "},
    {"Medical": "ถ่ายพยาธิ", "time": "9.00-10.00", "date": "11 ตุลาคม 2564 "},
    {
      "Medical": "ถ่ายพยาธิ",
      "time": "9.00-10.00",
      "date": "11 พฤศจิกายน 2564 "
    },
  ];
  List<Map<String, dynamic>> _foundAnimals = [];
  @override
  initState() {
    // at the beginning, all animals are shown
    _foundAnimals = _allAnimals;
    super.initState();
  }

  void runFilter(String _date) {
    List<Map<String, dynamic>> results = [];
    if (_date.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all animals
      results = _allAnimals;
    } else {
      results = _allAnimals
          .where((_allAnimals) =>
              _allAnimals["date"].toLowerCase().contains(_date.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      _foundAnimals = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ประวัติการฉีดวัคซีน',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HexColor('#697825'),
            Colors.white,
          ],
        )),
        child: ListView(
          children: [selectDate(), _buildListView()],
        ),
      ),
    );
  }

  Widget selectDate() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('วันที่',
                      style: TextStyle(fontSize: 18, color: Colors.white))),
            ),
            Container(
              height: 45.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(45))),
              width: double.infinity,
              child: TextButton(
                //color: Colors.white,
                onPressed: () {
                  _showDatePicker(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                          '${DateFormat("MMMM", 'th').formatInBuddhistCalendarThai(_date)}',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      child: _foundAnimals.isNotEmpty
          ? ListView.builder(
              itemCount: _foundAnimals.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Card(
                  elevation: 5,
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'การรักษา : ${_foundAnimals[index]["Medical"].toString()}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'เวลา : ${_foundAnimals[index]["time"].toString()}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'วันที่ : ${_foundAnimals[index]["date"].toString()}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            )
          : const Text(
              'ไม่พบข้อมูล',
              style: TextStyle(fontSize: 18),
            ),
    );
  }
}

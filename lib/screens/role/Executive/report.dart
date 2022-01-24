import 'package:flutter/material.dart';

class AnimalReport extends StatefulWidget {
  const AnimalReport({Key? key}) : super(key: key);

  @override
  _AnimalReportState createState() => _AnimalReportState();
}

class _AnimalReportState extends State<AnimalReport> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        appBar: AppBar(
          title: Text('รายงานการฉีดวัคซีน'),
          centerTitle: true,
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: ('มกราคม'),
              ),
              Tab(
                text: ('กุมภาพันธ์'),
              ),
              Tab(
                text: ('มีนาคม'),
              ),
              Tab(
                text: ('เมษายน'),
              ),
              Tab(
                text: ('พฤษภาคม'),
              ),
              Tab(
                text: ('มิถุนายน'),
              ),
              Tab(
                text: ('กรกฎาคม'),
              ),
              Tab(
                text: ('สิงหาคม'),
              ),
              Tab(
                text: ('กันยายน'),
              ),
              Tab(
                text: ('ตุลาคม'),
              ),
              Tab(
                text: ('พฤศจิกายน'),
              ),
              Tab(
                text: ('ธันวาคม'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: new Center(
                child: new Text(
                  "1",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "2",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "3",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "4",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "5",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "6",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "7",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "8",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "9",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "10",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "11",
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "12",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

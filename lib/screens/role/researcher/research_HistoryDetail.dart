import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/research.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResearchHistoryDetail extends StatefulWidget {
  final Data getResearch;
  const ResearchHistoryDetail({Key? key, required this.getResearch})
      : super(key: key);

  @override
  _ResearchHistoryDetailState createState() => _ResearchHistoryDetailState();
}

class _ResearchHistoryDetailState extends State<ResearchHistoryDetail> {
  //แปลง String เป็น DateFormat
  String formatDateFromString(String? date) {
    var parseDate = DateTime.parse(date!);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.getResearch.researchID}',
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _information(),
              ),
              _detail()
            ],
          ),
        ),
      ),
    );
  }

  Widget _information() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: _heading('ข้อมูล', 35.0, 80.0)),
              ),
              SizedBox(
                height: 10,
              ),
              _buildfont('รหัสงานวิจัย : ', '${widget.getResearch.researchID}'),
              _buildfont(
                'ชื่องานวิจัย : ',
                '${widget.getResearch.researchName}',
              ),
              _buildfont('ชนิดสัตว์ : ', '${widget.getResearch.typeName}'),
              _buildfont('อัพเดทล่าสุด : ',
                  '${formatDateFromString(widget.getResearch.date)}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: _heading('รายละเอียด', 35.0, 120.0)),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget.getResearch.researchDetail}',
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildfont(var title, var data) {
    return Container(
      width: 360,
      child: Row(
        children: [
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              data,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }

  Widget _heading(var title, double h, double w) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          color: HexColor("#697825"),
          borderRadius: BorderRadius.all(Radius.circular(45))),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

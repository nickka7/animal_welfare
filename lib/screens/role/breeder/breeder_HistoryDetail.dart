import 'package:flutter/material.dart';

import '../../../haxColor.dart';

class BreederHistoryDetail extends StatefulWidget {
  const BreederHistoryDetail({ Key? key }) : super(key: key);

  @override
  _BreederHistoryDetailState createState() => _BreederHistoryDetailState();
}

class _BreederHistoryDetailState extends State<BreederHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '123456',
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
            )
          ),
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
              _buildfont('รหัสการเพาะพันธุ์ : ', '123456'),
              _buildfont('ชื่อการเพาะพันธุ์ : ', 'การวิจัย'),
              _buildfont('ชนิดสัตว์ : ', 'ช้าง'),
              _buildfont('สถานะการเพาะพันธุ์ : ', 'สำเร็จ'),
              _buildfont('อัพเดทล่าสุด : ', '18 ตุลาคม 2564'),

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
                    child: Text('รายละเอียด',style: TextStyle(fontSize: 16),)),
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
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
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
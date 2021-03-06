import 'package:flutter/material.dart';

import '../../../haxColor.dart';

class AnimalData extends StatefulWidget {
  const AnimalData({Key? key}) : super(key: key);

  @override
  _AnimalDataState createState() => _AnimalDataState();
}

class _AnimalDataState extends State<AnimalData> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#697825"),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ช้าง',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(children: [
        _picture(),
        Padding(
          padding:
              const EdgeInsets.only(top: 210, bottom: 8, left: 10, right: 10),
          child: Container(
            child: Column(
              children: [
                _information(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _picture() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#E5E5E5"),
        borderRadius: BorderRadius.only(
            bottomLeft: (Radius.circular(45)),
            bottomRight: (Radius.circular(45))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                'https://www.naewna.com/uploads/news/source/479084.jpg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'สุขใจ',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            )
          ],
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
              _buildfont('ANIMAL ID : ', '123456'),
              _buildfont('ชนิด : ', 'ช้าง'),
              _buildfont('รหัสกรง : ', '123456'),
              _buildfont('เพศ : ', 'เมีย'),
              _buildfont('อายุ : ', '5 ปี'),
              _buildfont('น้ำหนัก : ', '4,000 กิโลกรัม'),
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
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
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

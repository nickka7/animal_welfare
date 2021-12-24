
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/book.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_MedicalHistory.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_VaccineHistory.dart';
import 'package:flutter/material.dart';

class VetAnimalData extends StatefulWidget {
  final Book getanimal;
  const VetAnimalData({Key? key, required this.getanimal}) : super(key: key);

  @override
  _VetAnimalDataState createState() => _VetAnimalDataState();
}

class _VetAnimalDataState extends State<VetAnimalData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#697825"),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ข้อมูลสัตว์',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          Stack(children: [
            picture(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 210, bottom: 8, left: 10, right: 10),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: information(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: medicalHistory(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: vaccineHistory(),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  //รูปและชื่อสัตว์
  Widget picture() {
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

  //ข้อมูลสัตว์แต่ละตัว
  Widget information() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              _buildfont('ANIMAL ID : ', '${widget.getanimal.id}'),
              _buildfont('ชนิด : ', '${widget.getanimal.title}'),
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

  //ประวัติการรักษาของแต่ละตัว
  Widget medicalHistory() {
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
                  child: _heading('ประวัติการรักษา', 35.0, 175.0)),
              SizedBox(
                height: 10,
              ),
              _buildfont('วันที่ : ', '18 ตุลาคม 2564'),
              _buildfont('การรักษา : ', 'ถ่ายพยาธิ'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VetMedicalHistory()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 220,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text('ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Colors.green,
                                )),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //ประวัติการฉีดวัคซีนของแต่ละตัว
  Widget vaccineHistory() {
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
                  child: _heading('ประวัติการฉีดวัคซีน', 35.0, 200.0)),
              SizedBox(
                height: 10,
              ),
              _buildfont('วันที่ : ', '18 ตุลาคม 2564'),
              _buildfont('วัคซีน : ', 'วัคซีนพิษสุนัขบ้า'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VetVaccineHistory()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 220,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text('ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Colors.green,
                                )),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //ขนาดและรูปแบบฟ้อนใน card
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

  //ขนาดและรูปแบบฟ้อนหัวข้อใน card
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

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/Aanimal%20caretaker/caretaker_searchAnimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaretakerFirstPage extends StatefulWidget {
  const CaretakerFirstPage({Key? key}) : super(key: key);

  @override
  _CaretakerFirstPageState createState() => _CaretakerFirstPageState();
}

class _CaretakerFirstPageState extends State<CaretakerFirstPage> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ผู้ดูแลสัตว์',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          // width: ,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
            colors: [
              Colors.blue,
              Colors.blue.shade200,
            ],
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _temp(),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor("#F2F2F2"),
                    borderRadius:
                        BorderRadius.only(topRight: (Radius.circular(60))),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [totalAnimal(), _workSchedule()],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget totalAnimal() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('สัตว์ภายใต้การดูแล',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Card(
              elevation: 5,
              // ignore: deprecated_member_use
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchAnimalData()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 75,
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('จำนวนสัตว์ทั้งหมด : 15 ตัว',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('ช้าง 5 ตัว',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('เสือ 10 ตัว',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                          size: 40,
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _workSchedule() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('เวลาให้อาหารสัตว์',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: HexColor('#697825'), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListView(
                    children: [
                      Text('09.00 ให้อาหารช้าง ',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _temp() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              'วันนี้, ${DateFormat("d MMMM ", 'th').format(today)}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            child: Text(
              '29 ',
              style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.air_outlined, color: Colors.white),
              SizedBox(
                width: 8,
              ),
              Text(
                'ความกดอากาศ ',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.air),
              SizedBox(
                width: 8,
              ),
              Text(
                'ความชื้น ',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

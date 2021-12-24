import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_searchAnimal.dart';
import 'package:flutter/material.dart';

class VetFirstpage extends StatefulWidget {
  const VetFirstpage({Key? key}) : super(key: key);

  @override
  _VetFirstpageState createState() => _VetFirstpageState();
}

class _VetFirstpageState extends State<VetFirstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'สัตวแพทย์',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: HexColor('#F2F2F2'),
        child: SingleChildScrollView(
          child: Column(
            children: [totalAnimal(), _workSchedule()],
          ),
        ),
      ),
    );
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
                          builder: (context) => const VetSearch()),
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
}

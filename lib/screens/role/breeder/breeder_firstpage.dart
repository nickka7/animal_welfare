import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/FilterAllAnimal.dart';
import 'package:animal_welfare/screens/role/breeder/breeder_searchHistory.dart';
import 'package:flutter/material.dart';

class BreederFirstpage extends StatefulWidget {
  const BreederFirstpage({ Key? key }) : super(key: key);

  @override
  _BreederFirstpageState createState() => _BreederFirstpageState();
}

class _BreederFirstpageState extends State<BreederFirstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'นักเพาะพันธุ์',
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
            children: [totalAnimal(), breederData()],
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
              child: Text('สัตว์ทั้งหมด',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 5,
              // ignore: deprecated_member_use
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  FilterAnimalData()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('จำนวนสัตว์ทั้งหมด : 300 ตัว',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
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


  Widget breederData() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  BreederSearchHistory()),
                    );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ข้อมูลการเพาะพันธุ์สัตว์แต่ละชนิด',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                  size: 40,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
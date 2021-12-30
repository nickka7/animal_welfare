import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/FilterAllAnimal.dart';
import 'package:animal_welfare/screens/allAnimalInZoo.dart';
import 'package:animal_welfare/screens/role/researcher/research_searchHistory.dart';
import 'package:flutter/material.dart';


class ResearcherFirstpage extends StatefulWidget {
  const ResearcherFirstpage({Key? key}) : super(key: key);

  @override
  _ResearcherFirstpageState createState() => _ResearcherFirstpageState();
}

class _ResearcherFirstpageState extends State<ResearcherFirstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'นักวิจัย',
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
            children: [totalAnimal(), researchData()],
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
                          builder: (context) =>  SearchAllAnimal()),
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

  Widget researchData() {
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
                          builder: (context) =>  ResearchHistory()),
                    );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ข้อมูลงานวิจัยสัตว์แต่ละชนิด',
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

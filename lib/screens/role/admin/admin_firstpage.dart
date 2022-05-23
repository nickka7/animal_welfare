import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/admin/DocHis.dart';
import 'package:animal_welfare/screens/role/admin/addEven.dart';
import 'package:animal_welfare/screens/role/admin/admin_repairHistory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'admin_uploadDocument.dart';

class AdminFirstpage extends StatefulWidget {
  const AdminFirstpage({Key? key}) : super(key: key);

  @override
  State<AdminFirstpage> createState() => _AdminFirstpageState();
}

class _AdminFirstpageState extends State<AdminFirstpage> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'งาน',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
            color: HexColor('#697825'),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            'วันที่',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          '${DateFormat("d", 'th').format(date)}',
                          style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '${DateFormat("MMMM yyyy", 'th').format(date)}',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#F2F2F2"),
                      borderRadius:
                          BorderRadius.only(topRight: (Radius.circular(60))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 25),
                      child: ListView(
                        children: [
                          title("อัปโหลดเอกสาร", UploadDocument()),
                          title("ประวัติการอัปโหลดเอกสาร", AdminDownloadFile()),
                          title("เพิ่มกิจกรรมในสวนสัตว์", AddEven()),
                          title("ดูแลการแจ้งซ่อม", AdminRepairHistory()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

//ขนาด สี ตัวอักษร
  Widget title(String text, var page) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Card(
            elevation: 5,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text,
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
        ),
      ],
    ));
  }
}

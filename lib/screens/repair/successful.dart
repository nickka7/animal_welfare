import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepairSuccessful extends StatefulWidget {
  const RepairSuccessful({Key? key}) : super(key: key);

  @override
  _RepairSuccessfulState createState() => _RepairSuccessfulState();
}

class _RepairSuccessfulState extends State<RepairSuccessful> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var formatterTime = DateFormat.Hm();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'แจ้งซ่อม',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      'สำเร็จ !',
                      style: TextStyle(
                          color: Colors.greenAccent[400], fontSize: 20),
                    ),
                    Text('คุณได้ยืนยันการแจ้งซ่อม',
                        style: TextStyle(fontSize: 16)),
                    Text('เรียบร้อยแล้ว', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.build_rounded,
                size: 70,
                color: Colors.greenAccent[400],
              ),
              SizedBox(
                height: 50,
              ),
              Text('${DateFormat("d MMMM yyy", 'th').format(today)} ${formatterTime.format(today)}', style: TextStyle(fontSize: 16)),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 5)
                    ]),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('เสร็จสิ้น',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  style: ElevatedButton.styleFrom(primary: HexColor('#697825')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

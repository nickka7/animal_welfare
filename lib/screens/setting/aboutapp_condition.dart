import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class ConditionOfUs extends StatefulWidget {
  const ConditionOfUs({ Key? key }) : super(key: key);

  @override
  _ConditionOfUsState createState() => _ConditionOfUsState();
}

class _ConditionOfUsState extends State<ConditionOfUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
        color: HexColor("#697825")
        ),
        ),
          centerTitle: true,
          title: Text('เงื่อนไขการเข้าใช้งาน',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      
    );
  }
}
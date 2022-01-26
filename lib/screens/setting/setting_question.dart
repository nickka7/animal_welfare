import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class OurQuestions extends StatefulWidget {
  const OurQuestions({ Key? key }) : super(key: key);

  @override
  _OurQuestionsState createState() => _OurQuestionsState();
}

class _OurQuestionsState extends State<OurQuestions> {
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
          title: Text('คำถามที่พบบ่อย',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i){
                      return Container(
                        decoration: BoxDecoration(
                        color: HexColor("#ECEFF0"),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,)]
                        ),
                    
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7
                        ),
                          child: Container(
                            child: Text('Question'),
                          ),
                      );
                    }
      ),
      
    );
  }
}
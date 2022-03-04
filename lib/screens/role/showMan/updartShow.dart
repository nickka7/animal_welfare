import 'package:flutter/material.dart';

class UpdateShow extends StatefulWidget {
  const UpdateShow({ Key? key }) : super(key: key);

  @override
  State<UpdateShow> createState() => _UpdateShowState();
}

class _UpdateShowState extends State<UpdateShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'โชว์',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
    );
  }
}
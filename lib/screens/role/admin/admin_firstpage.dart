import 'package:flutter/material.dart';

import 'admin_uploadDocument.dart';

class AdminFirstpage extends StatelessWidget {
  const AdminFirstpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ), body: ElevatedButton(onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadDocument()
        ),
      );
    }, child: Text('Upload Document')),
    );
  }
}

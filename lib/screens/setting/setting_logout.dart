import 'package:animal_welfare/screens/login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum DialogAction { yes, cancel }

class UserLogout {
  final storage = new FlutterSecureStorage();

  clearTokenAndLogout(
    BuildContext context,
  ) async {
    await storage.delete(key: 'token');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyLoginHome()),
        (Route<dynamic> route) => false);
  }

  static Future<DialogAction> yesCancelDialog(
    BuildContext context,
    String title,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
                child: Text(
                  'ยกเลิก',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                )),
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.yes),
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                )),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.cancel;
  }
}

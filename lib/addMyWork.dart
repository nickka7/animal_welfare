import 'dart:math';
import 'package:flutter/material.dart';
import 'api/notification_api.dart';


class AddMyWork extends StatefulWidget {
  const AddMyWork({Key? key}) : super(key: key);
  @override
  _AddMyWorkState createState() => _AddMyWorkState();
}

class _AddMyWorkState extends State<AddMyWork> {
  // static final DateFormat formatter = DateFormat('YYYY-MM-DD HH:mm:ss');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                NotificationService().cancelAllNotifications();
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Cancel All Notifications",
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                NotificationService().showNotification(Random().nextInt(1000), "title", "body", "2022-03-08 13:44:10");
                print('tap');
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                      "Show Notification"
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

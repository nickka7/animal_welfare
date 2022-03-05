// import 'package:flutter/material.dart';

// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// import 'api/notification_api.dart';

// class addMyWork extends StatefulWidget {
//   const addMyWork({Key? key}) : super(key: key);

//   @override
//   _addMyWorkState createState() => _addMyWorkState();
// }

// class _addMyWorkState extends State<addMyWork> {
//   //
//   // String? message;
//   // String channelId = "1000";
//   // String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
//   // String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";
//   //
//   // @override
//   // initState() {
//   //   message = "No message.";
//   //
//   //   var initializationSettingsAndroid =
//   //       AndroidInitializationSettings('logo_temporary');
//   //
//   //   var initializationSettingsIOS = IOSInitializationSettings(
//   //       onDidReceiveLocalNotification: (id, title, body, payload) {
//   //     print("onDidReceiveLocalNotification called.");
//   //   });
//   //   var initializationSettings = InitializationSettings(
//   //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   //
//   //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
//   //       onSelectNotification: (payload) {
//   //     // when user tap on notification.
//   //     print("onSelectNotification called.");
//   //     setState(() {
//   //       message = payload;
//   //     });
//   //   });
//   //   super.initState();
//   // }
//   //
//   // sendNotification() async {
//   //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//   //       '10000',
//   //       'FLUTTER_NOTIFICATION_CHANNEL',
//   //       'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
//   //       importance: Importance.max,
//   //       priority: Priority.high);
//   //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   //
//   //   var platformChannelSpecifics = NotificationDetails(
//   //       android: androidPlatformChannelSpecifics,
//   //       iOS: iOSPlatformChannelSpecifics);
//   //
//   //   await flutterLocalNotificationsPlugin.show(111, 'Hello, benznest.',
//   //       'This is a your notifications. ', platformChannelSpecifics,
//   //       payload: 'I just haven\'t Met You Yet');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('sss'),
//       ),
//       body: Text('aa'),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//        //   NotificationApi.showNotification(
//               title: 'title',
//               body: 'body',
//               payload: 'pppp');
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.send),
//       ),
//     );
//   }
// }

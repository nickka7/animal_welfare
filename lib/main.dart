import 'dart:convert';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/home/navigatorBar.dart';
import 'package:animal_welfare/screens/login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = new FlutterSecureStorage();

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "token");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',

        textTheme: TextTheme(
            button: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal)),
        //    scaffoldBackgroundColor:HexColor("#E5E5E5"),
        appBarTheme: AppBarTheme(
          color: HexColor("#697825"),
        ),
        backgroundColor: HexColor('#F2F2F2'),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('th'),
      ],
      locale: const Locale('th'),
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.data != "") {
            var str = snapshot.data;
            var jwt = str!.split(".");

            if(jwt.length !=3) {
              return MyLoginHome();
            } else {
              var payload = json.decode(utf8.decode(base64.decode(base64.normalize(jwt[1]))));
              if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                return NavigatorBar();//HomePage(str, payload);
              } else {
                return MyLoginHome();
              }
            }
          } else {
            return MyLoginHome();
          }
          },
      ),
    );
  }
}

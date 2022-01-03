import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/calender/event.dart';
import 'package:animal_welfare/screens/login/loginPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: MyLoginHome(),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:animal_welfare/addMyWork.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/home/navigatorBar.dart';
import 'package:animal_welfare/screens/login/loginPage.dart';
import 'package:animal_welfare/screens/setting/setting_logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api/notification_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = new FlutterSecureStorage();
  final navigatorKey = GlobalKey<NavigatorState>();
  Timer? _timer;

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "token");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  void initState() {
    super.initState();
    initializeTimer();
  }

  void initializeTimer() {
    // print("before if");
    if (_timer != null) {
      _timer!.cancel();
    }
    // setup action after...
    _timer = Timer(const Duration(minutes: 30), () => _handleInactivity());
  }

  void _handleInactivity() async {
    print("handleInactivity");
    _timer?.cancel();
    _timer = null;
    // UserLogout().clearTokenAndLogout(context);
    // Navigator.of(ContextClass().contexts).pushNamedAndRemoveUntil('<Your Route>', (Route<dynamic> route) => false);
    await storage.delete(key: 'token');
    navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyLoginHome()),
        (Route<dynamic> route) => false);

    print('after push');
  }

  @override
  Widget build(BuildContext context) {
    // ContextClass().contexts=context;
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => initializeTimer(),
        onPanDown: (_) => initializeTimer(),
        onPanUpdate: (_) => initializeTimer(),
        onPanEnd: (_) => initializeTimer(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
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
              if (!snapshot.hasData) return CircularProgressIndicator();
              if (snapshot.data != "") {
                var str = snapshot.data;
                var jwt = str!.split(".");
                //ไม่มีครบ 3 ส่วน
                if (jwt.length != 3) {
                  return MyLoginHome();
                } else {
                  var payload = json.decode(
                      utf8.decode(base64.decode(base64.normalize(jwt[1]))));
                  // print(payload.runtimeType);
                  // เช็คว่าวันหมดอายุอยู่หลังวันเวลาปัจจุบันป่าว
                  if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                      .isAfter(DateTime.now())) {
                    print(DateTime.fromMillisecondsSinceEpoch(
                            payload["exp"] * 1000)
                        .isAfter(DateTime.now()));
                    // NavigatorBar(payload: payload)
                    return NavigatorBar(
                        payload: payload); //HomePage(str, payload);
                  } else {
                    return MyLoginHome();
                  }
                }
              } else {
                return MyLoginHome();
              }
            },
          ),
        ));
  }
}
// class ContextClass{late BuildContext contexts = null; }

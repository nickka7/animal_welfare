import 'package:animal_welfare/screens/document/DownloadFile.dart';
import 'package:animal_welfare/screens/home/home.dart';

import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {
  final payload;
  const NavigatorBar({Key? key, this.payload}) : super(key: key);

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions = <Widget>[
    HomePage(payload: widget.payload),
    DownloadFile(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner_outlined, size: 30),
            label: 'เอกสาร',
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

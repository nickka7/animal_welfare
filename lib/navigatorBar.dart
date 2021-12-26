import 'package:animal_welfare/screens/document/DownloadFile.dart';
import 'package:animal_welfare/screens/home/home.dart';
import 'package:animal_welfare/screens/role/researcher/research_firstpage.dart';


import 'package:flutter/material.dart';


class NavigatorBar extends StatefulWidget {

  final String? firstName;
  const NavigatorBar({Key? key, this.firstName}) : super(key: key);

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions = <Widget>[
    HomePage(firstName: '${widget.firstName}'),
    DownloadFile(),
    Scaffold(),
    ResearcherFirstpage(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none, size: 30),
            label: 'แจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 30),
            label: 'โปรไฟล์',
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

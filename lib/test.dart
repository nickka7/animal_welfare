import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LazyLoadingPage extends StatefulWidget {
  const LazyLoadingPage({Key? key}) : super(key: key);

  @override
  _LazyLoadingPageState createState() => _LazyLoadingPageState();
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {

  late List myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    myList = List.generate(10, (i) => "Item : ${i + 1}");
    print(myList.length);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {  // จะเช็คจนะกระทั้ง scroll มาเจอจุดที่ต่ำที่สุด
        print('endla');
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      myList.add("Item : ${i + 1}");  // List จะถูกทำให้เพิ่มขึ้นทีละ 10 เมื่อมีการเรียก function
    }

    _currentMax = _currentMax + 10;  // currentMax จึงต้องเพิ่มด้วย ทีละ 10 ด้วย

    setState(() {});  // เมื่อได้ค่าที่เพิ่มมาอีก 10  แล้ว ก้อ refresh หน้าจอทีนึง
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LAZY LOADING BY Grassroot Engineer'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 80,
        itemBuilder: (context, i) {
          if (i == myList.length) {
            return CupertinoActivityIndicator();
          }
          return ListTile(
            title: Text(myList[i]),
          );
        },
        itemCount: myList.length + 1,
      ),
    );
  }
}
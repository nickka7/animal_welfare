import 'dart:convert';

import 'package:animal_welfare/api/research.dart';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/research.dart';
import 'package:animal_welfare/screens/calender/evenslide.dart';
import 'package:animal_welfare/screens/role/researcher/research_HistoryDetail.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/researcher/research_addresearch.dart';
import 'package:animal_welfare/screens/role/researcher/research_updateResearch.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ResearchHistory extends StatefulWidget {
  const ResearchHistory({Key? key}) : super(key: key);

  @override
  _ResearchHistoryState createState() => _ResearchHistoryState();
}

class _ResearchHistoryState extends State<ResearchHistory> {
  @override
  void initState() {
    init();
    super.initState();
  }

  List<Data> research = [];
  String query = '';

  Future init() async {
    final research = await ResearchApi.getResearch(query);

    setState(() => this.research = research);
  }

  late final SlidableController slidableController;
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;
  final snackBar = SnackBar(content: Text('ลบข้อมูลแล้ว'));

  String formatDateFromString(String? date) {
    var parseDate = DateTime.parse(date!);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  Future deleteBreeding(String researchID) async {
    print(researchID);
    String? token = await storage.read(key: 'token');
    var response = await http.delete(
        Uri.parse('$endPoint/api/deleteResearchData/$researchID'),
        headers: {"authorization": 'Bearer $token'});
    var jsonResponse = await json.decode(response.body);
    print(jsonResponse['message']);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลงานวิจัยสัตว์'),
        centerTitle: true,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (a, b, c) => ResearchHistory(),
            transitionDuration: Duration(milliseconds: 400),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HexColor('#697825'),
              Colors.white,
            ],
          )),
          child: ListView(
            children: [
              buildSearch(),
              buildListView(),
            ],
          ),
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddResearch()),
            ).then((value) => setState(() {}));
          },
          backgroundColor: HexColor("#697825"),
          child: const Icon(Icons.add),
        ),
      );

  Widget buildListView() => ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: research.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Card(
              elevation: 5,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResearchHistoryDetail(
                              getResearch: research[index])),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 90,
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'รหัสงานวิจัย : ${research[index].researchID}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'ชื่องานวิจัย : ${research[index].researchName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ชนิด : ${research[index].typeName}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'อัพเดตล่าสุด  ${formatDateFromString(research[index].date)}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                          size: 40,
                        )
                      ],
                    ),
                  )),
            ),
            
           ) ,
           secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'แก้ไข',
                                  color: Colors.green,
                                  icon: Icons.build_rounded,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateResearch(getResearch: research[index],
                                               
                                              )),
                                    );
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'ลบ',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.lightGreen[400],
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              'ยืนยันการลบ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text(
                                                  'ยกเลิก',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                              CupertinoDialogAction(
                                                  child: Text(
                                                    'ยืนยัน',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  onPressed: () {
                                                    deleteBreeding(
                                                            '${research[index].researchID}')
                                                        .then((value) =>
                                                            research
                                                                .removeAt(
                                                                    index))
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context))
                                                        .then((value) =>
                                                            setState(() {}))
                                                        .then((value) =>
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar));
                                                  })
                                            ],
                                          );
                                        });
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'ปิด',
                                  color: Colors.grey,
                                  icon: Icons.close,
                                  onTap: () {},
                                ),
                              ],);
          
        },
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "รหัสการวิจัย,ชื่อการวิจัย,ชนิดของสัตว์",
        onChanged: searchResearch,
      );

  void searchResearch(String query) async {
    final research = await ResearchApi.getResearch(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.research = research;
    });
  }
}

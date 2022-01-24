import 'dart:convert';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/repair/repair_notice.dart';
import 'package:animal_welfare/screens/repair/repair_notice_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animal_welfare/constant.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/model/repair.dart';
import 'package:intl/intl.dart';

class RepairHistory extends StatefulWidget {
  const RepairHistory({Key? key}) : super(key: key);

  @override
  _RepairHistoryState createState() => _RepairHistoryState();
}

class _RepairHistoryState extends State<RepairHistory> {
  @override
  void initState() {
    // getMaintenance();
    super.initState();
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }


  late final SlidableController slidableController;
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;

  Future<Repair> getMaintenance() async {
    String? token = await storage.read(key: 'token');
    var response = await http.get(Uri.parse('$endPoint/api/getMaintenance'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    var jsonData = Repair.fromJson(jsonDecode(response.body));
    print(jsonData);
    return jsonData;
  }
  Future deleteMaintenance(String maintenanceID) async {
    print(maintenanceID);
    String? token = await storage.read(key: 'token');
    var response = await http.delete(
        Uri.parse('$endPoint/api/deleteMaintenance/$maintenanceID'),
        headers: {"authorization": 'Bearer $token'});
    var jsonResponse = await json.decode(response.body);
    print(jsonResponse['message']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ประวัติการแจ้งซ่อม',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: _buildListView());
  }

  Widget _buildListView() {
    return FutureBuilder(
      future: getMaintenance(),
      builder: (BuildContext context, AsyncSnapshot<Repair> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                        Border.all(color: HexColor('#697825'), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 150,
                                  width: 80,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                    child: Image.network(
                                      '${snapshot.data!.data![index].image}',
                                      height: 113,
                                      width: 120,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    height: 90,
                                    width: 232,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "ปัญหาที่ชำรุด : ${snapshot
                                                      .data!.data![index]
                                                      .requestMessage}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "สถานที่ : ${snapshot.data!
                                                      .data![index].location}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "สถานะ : ${snapshot.data!
                                                      .data![index].status}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Align( 
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  child: Text(
                                    formatDateFromString('${snapshot.data!.data![index].createDtm}'),
                                    style: TextStyle(fontSize: 12),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //เลื่อนเพื่อแก้ไข ลบ ข้อมูล
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'แก้ไข',
                      color: Colors.green,
                      icon: Icons.build_rounded,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RepairNoticeUpdate(
                                      maintenanceID: '${snapshot.data!
                                          .data![index].maintenanceID}')),
                        );
                      },
                    ),
                    IconSlideAction(
                      caption: 'ลบ',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        final snackBar =
                        SnackBar(content: Text('ลบข้อมูลแล้ว'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          deleteMaintenance(
                              '${snapshot.data!.data![index].maintenanceID}')
                              .then((value) =>
                              snapshot.data!.data!.removeAt(index));
                        });
                      },
                    ),
                    IconSlideAction(
                      caption: 'ปิด',
                      color: Colors.grey,
                      icon: Icons.close,
                      onTap: () {},
                    ),
                  ],
                );
              });
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Text('กรุณารอสักครู่'),
              ],
            ),
          );
        }
      },
    );
  }
}

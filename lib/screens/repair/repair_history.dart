import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/repair/repair_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animal_welfare/constant.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/model/repair.dart';


class RepairHistory extends StatefulWidget {
  const RepairHistory({Key? key}) : super(key: key);

  @override
  _RepairHistoryState createState() => _RepairHistoryState();
}

class _RepairHistoryState extends State<RepairHistory> {
  late final SlidableController slidableController;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  final storage = new FlutterSecureStorage();


  // Future<http.Response> getMaintenance() async {
  //   String? token = await storage.read(key: 'token');
  //   String endPoint = Constant().endPoint;
  //   var response = http.get(Uri.parse('$endPoint/api/getMaintenance'),
  //       headers: {
  //         "Authorization": 'Bearer $token'});
  //   return
  // }


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
      // future:,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          ListView.builder(
              itemCount: entries.length,
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
                        border: Border.all(
                            color: HexColor('#697825'), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: Image.network(
                                    'https://image.makewebeasy.net/makeweb/0/V3VB7eir4/DefaultData/%E0%B8%9A%E0%B8%B1%E0%B8%99%E0%B9%84%E0%B8%94%E0%B9%84%E0%B8%A1%E0%B9%89%E0%B8%A2%E0%B8%B2%E0%B8%87%E0%B8%9E%E0%B8%B2%E0%B8%A3%E0%B8%B2%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%AA%E0%B8%B2%E0%B8%99%E0%B8%97%E0%B8%B3%E0%B8%AA%E0%B8%B5%E0%B8%AA%E0%B8%B3%E0%B9%80%E0%B8%A3%E0%B9%87%E0%B8%88%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%81%E0%B8%B1%E0%B8%9A%E0%B8%9E%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%A5%E0%B8%B2%E0%B8%A1%E0%B8%B4%E0%B9%80%E0%B8%99%E0%B8%951.jpg',
                                    height: 113,
                                    width: 120,
                                  ),
                                ),
                                Container(
                                  height: 90,
                                  width: 232,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "ปัญหาที่ชำรุด : Title which may be long, very very long",
                                                overflow: TextOverflow
                                                    .ellipsis,
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
                                                "สถานที่ : อาคาร A",
                                                overflow: TextOverflow
                                                    .ellipsis,
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
                                                "สถานะ : รอดำเนินการ",
                                                overflow: TextOverflow
                                                    .ellipsis,
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
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  child: Text(
                                    '12 ตุลาคม 2564 15:54',
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
                              builder: (context) => const RepairNotice()),
                        );
                      },
                    ),
                    IconSlideAction(
                      caption: 'ลบ',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        final snackBar = SnackBar(
                            content: Text('ลบข้อมูลแล้ว'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          entries.removeAt(index);
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
              }),
    );
  }
}

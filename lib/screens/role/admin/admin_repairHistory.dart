import 'package:animal_welfare/screens/role/admin/repair_status_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:animal_welfare/model/repair.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animal_welfare/constant.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AdminRepairHistory extends StatefulWidget {
  const AdminRepairHistory({Key? key}) : super(key: key);

  @override
  _AdminRepairHistoryState createState() => _AdminRepairHistoryState();
}

class _AdminRepairHistoryState extends State<AdminRepairHistory> {
  @override
  void initState() {
    super.initState();
    getAllMaintenance();
    scrollController.addListener(() {
      loadMore();
    });
  }

  ScrollController scrollController = ScrollController();
  int page = 1;
  int limit = 5;
  List listRepair = [];
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;

  late final SlidableController slidableController;
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;
  String? token;

  FutureOr onGoBack() {
    print('after pop');
    setState(() {
      getAllMaintenance();
      page = 1;
    });
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  void getAllMaintenance() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    token = await storage.read(key: 'token');
    try {
      var response = await http.get(
          Uri.parse(
              '$endPoint/api/getAllMaintenancePagination?limit=$limit&page=$page'),
          headers: {"authorization": 'Bearer $token'});
      // print('response ${response.body}');

      var jsonData = Repair.fromJson(jsonDecode(response.body));
      // print(jsonData.data);
      setState(() {
        listRepair = jsonData.data!;
        // print(listRepair);
      });
    } catch (err) {
      // print('1');
    }

    setState(() {
      isFirstLoadRunning = false;
    });
  }

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 50) {
      setState(() {
        isLoadMoreRunning = true; // Display a progress indic`ator at the bottom
      });
      page += 1;
      // print('page = $page');
      try {
        token = await storage.read(key: 'token');
        var response = await http.get(
            Uri.parse(
                '$endPoint/api/getAllMaintenancePagination?limit=$limit&page=$page'),
            headers: {"authorization": 'Bearer $token'});
        // print(response.body);
        final fetchedPosts = Repair.fromJson(jsonDecode(response.body));
        // print(fetchedPosts);
        if (fetchedPosts.data!.length > 0) {
          setState(() {
            listRepair.addAll(fetchedPosts.data!);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (err) {
        // print('2');
      }

      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  Future<String?> updateStatus(url) async {
    String? token = await storage.read(key: 'token');
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    //ถ้าไม่ได้เลือกรูปก็ไม่ต้องอัพรูป

    // request.fields['status'] = data['status'];
    // request.fields['location'] = data['location'];
    Map<String, String> headers = {
      "authorization": "Bearer $token",
      // "Content-Disposition": "attachment;filename=1.png",
      // "Content-Type": "image/png"
    };
    request.headers
        .addAll(headers); //['authorization'] = data['Bearer $token'];
    var res = await request.send();
    print('${res.reasonPhrase}test');
    return res.reasonPhrase;
  }

  final snackBar = SnackBar(content: Text('ซ่อมแล้ว'));

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
    return isFirstLoadRunning
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: listRepair.length,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Image.network(
                                            '${listRepair[index].image}',
                                            height: 113,
                                            width: 120,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                                                        "รหัสการแจ้งซ่อม : ${listRepair[index].maintenanceID}",
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
                                                        "ปัญหาที่ชำรุด : ${listRepair[index].requestMessage}",
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
                                                        "สถานที่ : ${listRepair[index].location}",
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
                                                        "สถานะ : ${listRepair[index].status}",
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
                                        ),
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        child: Text(
                                      formatDateFromString(
                                          '${listRepair[index].createDtm}'),
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
                            caption: 'ซ่อมแล้ว',
                            color: Colors.green,
                            icon: Icons.build_rounded,
                            onTap: () {
                              updateStatus(
                                '${Constant().endPoint}/api/updateStatusMaintenance?maintenanceID=${listRepair[index].maintenanceID}&status=ซ่อมแล้ว',
                              ).then((value) => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.lightGreen[400],
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: Text(
                                        'ยืนยันการแก้ไข',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text(
                                            'ยกเลิก',
                                            style: TextStyle(color: Colors.red),
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
                                              updateStatus(
                                                '${Constant().endPoint}/api/updateStatusMaintenance?maintenanceID=${listRepair[index].maintenanceID}&status=ซ่อมแล้ว',
                                              ).then((value) => Navigator.pop(context))
                                                  .then((value) =>
                                                      setState(() {}))
                                                  .then((value) =>
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar));
                                            })
                                      ],
                                    );
                                  }));

                              //   .then((value) => setState(() {}))
                              //   .then((value) => ScaffoldMessenger.of(context)
                              // .showSnackBar(snackBar));
                            },
                          ),
                          // IconSlideAction(
                          //   caption: 'รอดำเนินการ',
                          //   color: Colors.red,
                          //   icon: Icons.build_rounded,
                          //   onTap: () {
                          //     updateStatus(
                          //             '${Constant().endPoint}/api/updateStatusMaintenance?maintenanceID=${listRepair[index].maintenanceID}&status=รอดำเนินการ',
                          //             )
                          //         .then((value) => setState(() {}))
                          //         .then((value) => ScaffoldMessenger.of(context)
                          //       .showSnackBar(snackBar));
                          //   },
                          // ),
                          IconSlideAction(
                            caption: 'ปิด',
                            color: Colors.grey,
                            icon: Icons.close,
                            onTap: () {},
                          ),
                        ],
                      );
                    }),
              ),
              if (isLoadMoreRunning == true)
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
  }
}

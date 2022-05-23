import 'dart:async';
import 'dart:convert';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/logout/setting_logout.dart';
import 'package:animal_welfare/screens/repair/repair_notice_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animal_welfare/constant.dart';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/model/repair.dart';
import 'package:intl/intl.dart';

class RepairHistoryPagination extends StatefulWidget {
  const RepairHistoryPagination({Key? key}) : super(key: key);

  @override
  _RepairHistoryPaginationState createState() =>
      _RepairHistoryPaginationState();
}

class _RepairHistoryPaginationState extends State<RepairHistoryPagination> {
  @override
  void initState() {
    super.initState();
    getMaintenance();
    scrollController.addListener(() {
      loadMore();
      // if (scrollController.position.pixels ==
      //     scrollController.position.maxScrollExtent) {
      //   print("At the end");
      // print(amountListView);
      // loadMoreItems();
      // }
    });
  }

  // @override
  // void dispose() {
  //   scrollController.dispose();
  //   super.dispose();
  // }

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
  final snackBar = SnackBar(content: Text('ลบข้อมูลแล้ว'));
  String? token;

  FutureOr onGoBack() {
    print('after pop');
    setState(() {
      getMaintenance();
      page = 1;
    });
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  void getMaintenance() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    token = await storage.read(key: 'token');
    try {
      var response = await http.get(
          Uri.parse(
              '$endPoint/api/getMaintenancePagination?limit=$limit&page=$page'),
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

    // var jsonDataa = jsonDecode(response.body)['data'];
    // print('decode $jsonDataa');
    // print('fromjson ${jsonDataa[0]['location']}');
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
                '$endPoint/api/getMaintenancePagination?limit=$limit&page=$page'),
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

  Future deleteMaintenance(String maintenanceID) async {
    // print(maintenanceID);
    String? token = await storage.read(key: 'token');
    var response = await http.delete(
        Uri.parse('$endPoint/api/deleteMaintenance/$maintenanceID'),
        headers: {"authorization": 'Bearer $token'});
    var jsonResponse = await json.decode(response.body);
    // print(jsonResponse['message']);
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
                        // actionExtentRatio: 0.25,
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
                            caption: 'แก้ไข',
                            color: Colors.green,
                            icon: Icons.build_rounded,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RepairNoticeUpdate(
                                          maintenanceID:
                                              '${listRepair[index].maintenanceID}',
                                          location:
                                              '${listRepair[index].location}',
                                          maintenanceDetail:
                                              '${listRepair[index].requestMessage}',
                                        )),
                              ).then((value) =>
                                  onGoBack()); //หลังจาก call back เรียก setState
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
                                                    deleteMaintenance(
                                      '${listRepair[index].maintenanceID}').then((value) => Navigator.pop(context),)
                                  .then((value) => listRepair.removeAt(index))
                                  .then((value) => setState(() {}))
                                  .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar));
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
              // if (hasNextPage == false)
              //   Container(
              //     padding: const EdgeInsets.only(top: 30, bottom: 40),
              //     color: Colors.amber,
              //     child: Center(
              //       child: Text('ข้อมูลครบแล้ว'),
              //     ),
              //   ),
            ],
          );
  }
}

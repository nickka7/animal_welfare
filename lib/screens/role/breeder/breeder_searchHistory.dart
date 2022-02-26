import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/api/breeding.dart';
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/breeding.dart';
import 'package:animal_welfare/screens/role/breeder/breeder_HistoryDetail.dart';
import 'package:animal_welfare/screens/role/breeder/breeder_addbreeding.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../haxColor.dart';

class BreederSearchHistory extends StatefulWidget {
  const BreederSearchHistory({Key? key}) : super(key: key);

  @override
  _BreederSearchHistoryState createState() => _BreederSearchHistoryState();
}

class _BreederSearchHistoryState extends State<BreederSearchHistory> {
  @override
  void initState() {
    init();
    super.initState();
  }
  late final SlidableController slidableController;
  final storage = new FlutterSecureStorage();
  String endPoint = Constant().endPoint;
  final snackBar = SnackBar(content: Text('ลบข้อมูลแล้ว'));

  List<Data> breeding = [];
  String query = '';

  Future init() async {
    final breeding = await BreedingApi.getResearch(query);

    setState(() => this.breeding = breeding);
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

    Future deleteBreeding(String breedingID) async {
    print(breedingID);
    String? token = await storage.read(key: 'token');
    var response = await http.delete(
        Uri.parse('$endPoint/api/deleteBreedingData/$breedingID'),
        headers: {"authorization": 'Bearer $token'});
    var jsonResponse = await json.decode(response.body);
    print(jsonResponse['message']);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('ข้อมูลการเพาะพันธุ์สัตว์'),
          centerTitle: true,
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
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
         floatingActionButton: FloatingActionButton(
        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddBreeding()),
                          ).then((value) =>
                              setState(() {}));
                        },
                        backgroundColor: HexColor("#697825"),
                        child: const Icon(Icons.add),
      ),
      );
  Widget buildListView() => ListView.builder(
    
      itemCount: breeding.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,

        secondaryActions: <Widget>[
                          
                          IconSlideAction(
                            caption: 'ลบ',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              deleteBreeding(
                                      '${breeding[index].breedingID}')
                                  .then((value) => breeding.removeAt(index))
                                  .then((value) => setState(() {}))
                                  .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar));
                            },
                          ),
                          IconSlideAction(
                            caption: 'ปิด',
                            color: Colors.grey,
                            icon: Icons.close,
                            onTap: () {},
                          ),
                        ], child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Card(
            elevation: 5,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BreederHistoryDetail(getBreeding: breeding[index])),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 90,
                        width: 270,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'รหัสการเพาะพันธุ์ : ${breeding[index].breedingID}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'ชื่อการเพาะพันธุ์ : ${breeding[index].breedingName}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ชนิด : ${breeding[index].typeName}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'อัพเดตล่าสุด  ${formatDateFromString(breeding[index].date)}',
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
        ),
                      );
      });

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "รหัสการเพาะพันธุ์,ชื่อการเพาะพันธุ์,ชนิดของสัตว์",
        onChanged: searchBreeding,
      );

  void searchBreeding(String query) async {
    final breeding = await BreedingApi.getResearch(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.breeding = breeding;
    });
  }
}

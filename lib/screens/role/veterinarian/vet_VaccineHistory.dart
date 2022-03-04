import 'dart:convert';

import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/model/vaccineHIs.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_addVaccinate.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../constant.dart';

class VetVaccineHistory extends StatefulWidget {
  final String? animalID;
  final Bio getanimal;
  const VetVaccineHistory({Key? key, required this.animalID, required this.getanimal}) : super(key: key);

  @override
  _VetVaccineHistoryState createState() => _VetVaccineHistoryState();
}

class _VetVaccineHistoryState extends State<VetVaccineHistory> {
  @override
  void initState() {
    init();
    super.initState();
  }

  final storage = new FlutterSecureStorage();
  List<DataVaccinate> vaccine = [];
  String query = '';

  Future<List<DataVaccinate>> getAllvaccinate(String query) async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    final allvaccinate;
    var response = await http.get(
        Uri.parse(
            '$endPoint/api/getVaccineHistory?animalID=${widget.animalID}'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    if (response.statusCode == 200) {
      allvaccinate = json.decode(response.body);
      final List vaccine = allvaccinate['data'];
      // print('bioo $bio');
      return vaccine.map((json) => DataVaccinate.fromJson(json)).where((allvaccinate) {
        final allvaccinateIDLower = allvaccinate.vaccinateID.toString();
        final allvaccinateNameLower = allvaccinate.vaccineName;
        final searchLower = query;
        return allvaccinateIDLower.contains(searchLower) ||
            allvaccinateNameLower!.contains(searchLower);
      }).toList();
    } else {
      print('not 200');
      throw Exception();
    }
  }

  Future init() async {
    final vaccine = await getAllvaccinate(query);

    setState(() => this.vaccine = vaccine);
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ประวัติการฉีดวัคซีน',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => VetVaccineHistory( animalID: widget.animalID, getanimal: widget.getanimal,),
              transitionDuration: Duration(milliseconds: 400),
            ),
          ),
      
      child : Container(
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
          children: [buildSearch(), buildListview()],
        ),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddVaccinate(
                       getanimal: widget.getanimal,
                    )),
          ).then((value) => setState(() {}));
        },
        backgroundColor: HexColor("#697825"),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildListview() {
    return ListView.builder(
        itemCount: vaccine.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          final vaccinate = vaccine[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 90,
                      width: 280,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'รหัสการฉีดวัคซีน : ${vaccinate.vaccinateID}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'วัคซีน : ${vaccinate.vaccineName}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'เวลา : ${vaccinate.time}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'วันที่ : ${formatDateFromString(vaccinate.date.toString())}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "รหัสการฉีดวัคซีน,รหัสสัตว์",
        onChanged: searchAnimal,
      );

  void searchAnimal(String query) async {
    final vaccine = await getAllvaccinate(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.vaccine = vaccine;
    });
  }
}

import 'dart:convert';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/MedHis.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/screens/role/veterinarian/Medical/vat_updateMedHis.dart';
import 'package:animal_welfare/screens/role/veterinarian/Medical/vet_addMedical.dart';
import 'package:animal_welfare/screens/role/veterinarian/Medical/vet_medHisDetail.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../constant.dart';
import '../../../../main.dart';

class VetMedicalHistory extends StatefulWidget {
  final Bio getBio;
  const VetMedicalHistory({Key? key, required this.getBio}) : super(key: key);

  @override
  _VetMedicalHistoryState createState() => _VetMedicalHistoryState();
}

class _VetMedicalHistoryState extends State<VetMedicalHistory> {
  @override
  void initState() {
    init();
    super.initState();
  }

  final storage = new FlutterSecureStorage();
   String endPoint = Constant().endPoint;
     final snackBar = SnackBar(content: Text('ลบข้อมูลแล้ว'));
  List<Medical> medHis = [];
  String query = '';

  Future<List<Medical>> getAllMedical(String query) async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    final allmedical;
    var response = await http.get(
        Uri.parse(
            '$endPoint/api/getMedicalHistory?animalID=${widget.getBio.animalID}'),
        headers: {"authorization": 'Bearer $token'});
    print(response.body);
    if (response.statusCode == 200) {
      allmedical = json.decode(response.body);
     
      final List medical = allmedical['data'];
      // print('bioo $bio');
      return medical.map((json) => Medical.fromJson(json)).where((medical) {
        final medicalLower = medical.medicalName!;
        final searchLower = query;
        return medicalLower.contains(searchLower);
      }).toList();
    } else {
      print('not 200');
      throw Exception();
    }
  }

  Future init() async {
    final medHis = await getAllMedical(query);

    setState(() => this.medHis = medHis);
  }

  String formatDateFromString(String date) {
    var parseDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(parseDate);
    return formattedDate;
  }

  Future deleteMedical(String researchID) async {
    print(researchID);
    String? token = await storage.read(key: 'token');
    var response = await http.delete(
        Uri.parse('$endPoint/api/deleteMedicalData/$researchID'),
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
          'ประวัติการรักษา',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => VetMedicalHistory(getBio: widget.getBio,),
              transitionDuration: Duration(milliseconds: 400),
            ),
          ),
    child :  Container(
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
                builder: (context) => AddMedical(
                      getanimal: widget.getBio,
                    )),
          ).then((value) => setState(() {}));
        },
        backgroundColor: HexColor("#697825"),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildListview() {
    return  ListView.builder(
        itemCount: medHis.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          final animal = medHis[index];
          return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Card(
              elevation: 5,
              child:TextButton(onPressed: () { 
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MedicalDetail(
                              getMedHis: animal)),
                    );
               },
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: 280,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'การรักษา : ${animal.medicalName}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'เวลา : ${animal.time}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'วันที่ : ${formatDateFromString(animal.date.toString())}',
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
          )),
          secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'แก้ไข',
                                  color: Colors.green,
                                  icon: Icons.build_rounded,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateMedical(getMedical: animal, getanimal: widget.getBio,
                                               
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
                                                    deleteMedical(
                                                            '${animal.medicalID}')
                                                        .then((value) =>
                                                            medHis
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
        });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "รหัสการรักษา,การรักษา,รหัสสัตว์",
        onChanged: searchAnimal,
      );

  void searchAnimal(String query) async {
    final medHis = await getAllMedical(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.medHis = medHis;
    });
  }
}

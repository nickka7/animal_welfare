import 'dart:convert';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/MedHis.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_addMedical.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../constant.dart';
import '../../../main.dart';

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
    return ListView.builder(
        itemCount: medHis.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          final animal = medHis[index];
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
          );
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

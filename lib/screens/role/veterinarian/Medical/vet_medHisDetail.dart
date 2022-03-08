import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/MedHis.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalDetail extends StatefulWidget {
  final Medical getMedHis;
  const MedicalDetail({Key? key, required this.getMedHis}) : super(key: key);

  @override
  State<MedicalDetail> createState() => _MedicalDetailState();
}

class _MedicalDetailState extends State<MedicalDetail> {
  String formatDateFromString(String? date) {
    var parseDate = DateTime.parse(date!);
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
          'รหัสการรักษา ${widget.getMedHis.medicalID}',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: _heading('การรักษา', 35.0, 120.0)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${widget.getMedHis.medicalName ?? ''}',
                                  style: TextStyle(fontSize: 16),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
               Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: _heading('รายละเอียด', 35.0, 120.0)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${widget.getMedHis.detail ?? ''}',
                                  style: TextStyle(fontSize: 16),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _heading(var title, double h, double w) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          color: HexColor("#697825"),
          borderRadius: BorderRadius.all(Radius.circular(45))),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

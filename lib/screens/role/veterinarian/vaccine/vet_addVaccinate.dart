import 'package:animal_welfare/api/vaccine.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/all_animals_with_role.dart';
import 'package:animal_welfare/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddVaccinate extends StatefulWidget {
  final Bio getanimal;
  const AddVaccinate({Key? key, required this.getanimal}) : super(key: key);

  @override
  _AddVaccinateState createState() => _AddVaccinateState();
}

class _AddVaccinateState extends State<AddVaccinate> {
  late FixedExtentScrollController scrollController;

  final _formKey = GlobalKey<FormState>();
  Future<void>? api;
  @override
  void initState() {
    super.initState();
    api = vaccineApi.getVaccine();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final VaccineApi vaccineApi = VaccineApi();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'เพิ่มการฉีดวัคซีน',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<void>(
            future: api,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: _heading('ข้อมูล', 35.0, 80.0)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildfont('ANIMAL ID : ',
                                      '${widget.getanimal.animalID}'),
                                  _buildfont('ชนิด : ',
                                      '${widget.getanimal.typeName}'),
                                  _buildfont(
                                      'เพศ : ', '${widget.getanimal.gender}'),
                                  _buildfont(
                                      'อายุ : ', '${widget.getanimal.age} ปี'),
                                  _buildfont('น้ำหนัก : ',
                                      '${widget.getanimal.weight} กิโลกรัม'),
                                  _buildfont(
                                      'กรง : ', '${widget.getanimal.cageID} ')
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'วัคซีน',
                              style: TextStyle(fontSize: 18),
                            )),
                        Container(
                          height: 58,
                          width: double.infinity,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side:
                                    BorderSide(width: 1, color: Colors.black45),
                              ),
                              onPressed: () {
                                scrollController.dispose();
                                scrollController = FixedExtentScrollController(
                                    initialItem: index);
                                _vaccinePicker(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${vaccineApi.vaccineID[index]}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 70),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Map<String, String> data = {
                                "vaccineID": vaccineApi.vaccineID[index].split(" ")[0],
                              };
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.lightGreen[400],
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: Text(
                                        'ยืนยันการเพิ่มการฉีดวัคซีน',
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
                                              vaccineApi.uploadData(
                                                      '${Constant().endPoint}/api/postVaccineData/?animalID=${widget.getanimal.animalID}',
                                                      data)
                                                  .then((value) {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                // setState(() {});
                                                final snackBar = SnackBar(
                                                    content: Text(
                                                        'เพิ่มการฉีดวัคซีนเรียบร้อยแล้ว'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              });
                                            })
                                      ],
                                    );
                                  });
                            },
                            child: Text('เสร็จสิ้น',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                                primary: HexColor('#697825')),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return new Center(child: new CircularProgressIndicator());
              }
            }));
  }

  void _vaccinePicker(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  scrollController: scrollController,
                  children: vaccineApi.vaccineID.map((item) {
                    return Center(
                      child: Text(
                        '${item.toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      this.index = index;
                      final item = '${vaccineApi.vaccineID[index]}';
                      //var result = vaccineID[index].substring(0, 6);
                      print('selected $item');
                    });
                  },
                  diameterRatio: 1,
                  useMagnifier: true,
                  magnification: 1.3,
                ),
              ),
              CupertinoButton(
                child: Text('ยืนยัน'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildfont(var title, var data) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
          )
        ],
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

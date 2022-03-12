import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/role/Executive/animalReport.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CeoHome extends StatefulWidget {
  const CeoHome({
    Key? key,
  }) : super(key: key);

  @override
  _CeoHomeState createState() => _CeoHomeState();
}

class _CeoHomeState extends State<CeoHome> {
  // DateTime myDateTime = DateTime.now();

  // @override
  // void initState() {
  //   getAnimal();
  //   super.initState();
  // }

  // final storage = new FlutterSecureStorage();

  // Future<AllAnimals> getAnimal() async {
  //   String? token = await storage.read(key: 'token');
  //   String endPoint = Constant().endPoint;
  //   var response = await http.get(Uri.parse('$endPoint/api/getAnimalInZoo'),
  //       headers: {"authorization": 'Bearer $token'});
  //   print(response.body);
  //   var jsonData = AllAnimals.fromJson(jsonDecode(response.body));
  //   print('$jsonData');
  //   return jsonData;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'งาน',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        //  decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
          // color: 
          //   HexColor('#697825'),
        //     Colors.white,
        //   ],
        // )),
        // margin: EdgeInsets.all(8.0),
        child: Column(
           children: [
          //   Container(
              
          //     height: 320,
          //    // color: Colors.white,
          //     child: Column(
          //       children: [
          //         Flexible(
          //           child: Container(
          //             height: 130,
          //             child: TextButton(
          //               child: buildStatCard(
          //                   'จำนวนผู้เข้าชมสวนสัตว์', 5, 'คน', HexColor("#9B7401")),
          //               onPressed: () => {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => QuantityVisitors()),
          //                 ),
          //               },
          //             ),
          //           ),
          //         ),
          //          Container(
          //     child: Row(
          //       children: [
          //         Flexible(
          //           child: Container(
          //             height: MediaQuery.of(context).size.height * 0.2,
          //             width: 200,
          //             child: TextButton(
          //               child: buildStatCard('เจ้าหน้าที่\nที่มาปฏิบัติงาน', 5,
          //                   'คน', HexColor("#3B5998")),
          //               onPressed: () => {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => QuantityEmployee()),
          //                 ),
          //               },
          //             ),
          //           ),
          //         ),
          //         Flexible(
          //           child: Container(
          //               height: MediaQuery.of(context).size.height * 0.2,
          //               width: 190,
          //               child: FutureBuilder<AllAnimals>(
          //                 future: getAnimal(),
          //                 builder: (BuildContext context,
          //                     AsyncSnapshot<AllAnimals> snapshot) {
          //                   if (snapshot.hasData) {
          //                     return TextButton(
          //                       child: buildStatCard(
          //                           'จำนวนสัตว์',
          //                           snapshot.data!.data!.amount,
          //                           'ตัว',
          //                           HexColor("#28B446")),
          //                       onPressed: () => {
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) =>
          //                                   SearchAllAnimal()),
          //                         ),
          //                       },
          //                     );
          //                   } else {
          //                     return new Center(
          //                       child: new CircularProgressIndicator(),
          //                     );
          //                   }
          //                 },
          //               )),
          //         ),
          //       ],
          //     ),
          //   ),
          //   Padding(
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: <Widget>[
          //         Text(
          //             'อัพเดทข้อมูลล่าสุด : ${DateFormat("dd/MM/yyyy HH:mm").format(myDateTime)}',
                     
          //             textAlign: TextAlign.right)
          //       ],
          //     ),
          //   ),
          //       ],
          //     ),
          //   ),
          //  SizedBox(height: 15,),
            
          //   Padding(
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          //     child: Card(
          //         color: HexColor('#697825'),
          //       elevation: 5,
          //       child: TextButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => AnimalReportTest()),
          //           );
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text('รายงานการเข้างานของพนักงาน',
          //                   style:
          //                       TextStyle(fontSize: 16, color: Colors.white)),
          //               Icon(
          //                 Icons.navigate_next,
          //                 color: Colors.white,
          //                 size: 40,
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Card(
                color: HexColor('#697825'),
                elevation: 5,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimalReportTest()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('รายงานการฉีดวัคซีนของสัตว์แต่ละชนิด',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
        ),
      ),
    );
  }

  buildStatCard(String title, int? count, String text, HexColor color) {
    return Container(
      //  margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 4.0),
            blurRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Center(
            child: Text(
              '${NumberFormat("###,###").format(count)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

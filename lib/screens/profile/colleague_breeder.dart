import 'package:animal_welfare/model/get_sky_line.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/screens/profile/craetaker_profile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CollBreeder extends StatefulWidget {
  const CollBreeder({ Key? key }) : super(key: key);

  @override
  _CollBreederState createState() => _CollBreederState();
}

class _CollBreederState extends State<CollBreeder> {

  Future<GetFlightArea> loadFlightArea() async{
    Uri url = Uri.parse(
      'https://flight-data4.p.rapidapi.com/get_area_flights?latitude=13.0003022&longitude=96.9923911');
    
    http.Response response = await http.get(url, headers: {
      "x-rapidapi-host": "flight-data4.p.rapidapi.com",
      "x-rapidapi-key": "8995a8cc8cmshe10cb8d52233a86p11c409jsn27b93c7616c2",
      "Content-Type": "application/json"
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      return GetFlightArea.fromJson(json.decode(response.body));
      

    } else {
      throw Exception('Failed');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
        color: HexColor("#697825")
        ),
        ),
          centerTitle: true,
          title: Text('นักเพาะพันธุ์',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<GetFlightArea> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              CircularProgressIndicator();
              print ('circle waiting');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              print ('Done');

              return
      Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
                  // height: 20.0,
                  // color: Colors.blue,
                  //color: Colors.blue,
                  margin: const EdgeInsets.symmetric(
                  horizontal: 15
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('ทั้งหมด คน',
                  style: TextStyle(
                        color: HexColor("#34C1FF"),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                      ),),
                ],
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: ListView.builder(
                    itemCount: 10,
                    // snapshot.data?.flights?.length ?? 0
                    itemBuilder: (context, i){
                      return Container(
                        decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#BFF073")),
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,)]
                        ),
                    
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7
                        ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ignore: deprecated_member_use
                              FlatButton(
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 7
                                      ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                       Container(
                                        width: 90.0,
                                        height: 90.0,
                                        
                                         decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        //  image: DecorationImage(
                                        // fit: BoxFit.fill,
                                        // image: NetworkImage('${dataWorld[i].countryInfo.flag}')
                                        //  ),
                                         color: Colors.black54
                                         )
                                       ),
                                       Flexible(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            cardDetail('name', 'email','lineid'),
                                            // 'Place Name : ${snapshot.data?.flights?[i].airline ?? 'ไม่พบข้อมูล'}'
                                          ],
                                        )
                                       ), 
                                       
                                          
                                        
                                      ],
                                  ),
                                ),
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerProfile()));
                                  },
                              ),
                            ],
                          ),
                        );
                    },
                  ),
                  flex: 13,
          ),

        ],
      );
      } else {
              return Text('ไม่สามารถโหลดข้อมูลได้');
            }
          },
          future: loadFlightArea(),
      )
    );
  }

  

  Expanded cardDetail(String name, String email, String lineid) {
    return Expanded(
      
      child: Container(
        width: 150.0,
        height: 100.0,
        //color: Colors.blue,
        margin: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 5
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

              Text (name,
              style: TextStyle(
                color: HexColor("#34C1FF"),
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),  
            ),
            //),
            Row(
              children: [ 
                Text('E-mail : ',
                  style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (email,
              style: TextStyle(
                color: HexColor("#34C1FF"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),
            Row(
              children: [ 
                Text('Line ID : ',
                  style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                  ),
                  ),

              Text (lineid,
              style: TextStyle(
                color: HexColor("#34C1FF"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),  
            ),
              ],
            ),

            
          ],
      ),
      ),
    );
  }
  
}
import 'dart:convert';
import 'package:animal_welfare/model/news.dart';
import 'package:animal_welfare/screens/calender/event.dart';
import 'package:animal_welfare/screens/home/hotNews.dart';
import 'package:animal_welfare/screens/meeting/meeting_booking.dart';
import 'package:animal_welfare/screens/meeting/meeting_history.dart';
import 'package:animal_welfare/screens/repair/repair_Page.dart';
import 'package:animal_welfare/screens/role/Executive/animalReport.dart';
import 'package:animal_welfare/screens/role/Executive/executive_main.dart';
//import 'package:animal_welfare/screens/role/Executive/report.dart';
import 'package:animal_welfare/screens/role/admin/admin_firstpage.dart';
import 'package:animal_welfare/screens/role/animal%20caretaker/caretaker_fristpage.dart';
import 'package:animal_welfare/screens/role/breeder/breeder_firstpage.dart';
import 'package:animal_welfare/screens/role/researcher/research_firstPage.dart';
import 'package:animal_welfare/screens/role/showMan/show.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_firstpage.dart';
import 'package:animal_welfare/screens/setting/setting_home.dart';
import 'package:animal_welfare/screens/timecheck/time_check.dart';
import 'package:animal_welfare/widget/seemore.dart';
import 'package:flutter/material.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class HomePage extends StatefulWidget {
  final payload;
 // final String? image;
  const HomePage({Key? key,this.payload}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    getNews();
    super.initState();
  }

  // Future getProfile() async {
  //   String? token = await storage.read(key: 'token');
  //   print('can get token: $token');
  //   print('${widget.firstName}');
  // }

  Future<NewsData> getNews() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getNews/0'),
        headers: {"authorization": 'Bearer $token'});
    
    // print(response.body);
    var jsonData = NewsData.fromJson(jsonDecode(response.body));
    // print(jsonData);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            _headSection(),
            Container(
                width: double.infinity, height: 200, child: HotnewsSlider()),
            buttonSection(),
            //buttonSection(),
            listnews()
          ],
        )),
      ),
    );
  }

  Widget _headSection() {
    return Container(
      height: 150,
      width: double.infinity,
      color: HexColor("#697825"),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Image(
              image: AssetImage('assets/bg1.png'),
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: 138.0,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        /* backgroundImage: NetworkImage(
                            'https://saosuay.com/wp-content/uploads/2019/11/B347C0D7-F64C-4112-B651-17F86F466A7E-833x1024.jpeg'),*/
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'สวัสดี',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              '${widget.payload['firstName']}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget buttonSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: SingleChildScrollView(
        child: Column(children: [
          Wrap(
            children: [
              _buildButton(Icons.timer, 'เวลาเข้าออกงาน', WorkTimeCheck()),
              _buildButton(
                  Icons.calendar_today, 'ปฏิทินกิจกรรม', CalendarScreenTest()),
              _buildButton(
                  Icons.assistant_photo_outlined, 'จองห้องประชุม', MyMeetingHistory()),
              _buildButton(Icons.settings, 'ตั้งค่า', MySettingHome()),
              _buildButton(Icons.build_outlined, 'แจ้งซ่อม', RepairPage()),
              buildButton(),
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildButton() {
    return Container(
      width: 130,
      height: 90,
      child: TextButton(
        onPressed: () {
          setState(() {
            switch (widget.payload['role']) {
              case 'ceo':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CeoHome()),
                  );
                }
                break;
              case 'caretaker':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CaretakerFirstPage()),
                  );
                }
                break;
              case 'veterinarian':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VetFirstpage()),
                  );
                }
                break;
              case 'researcher':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResearcherFirstpage()),
                  );
                }
                break;
              case 'breeder':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BreederFirstpage()),
                  );
                }
                break;
              case 'showman':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowScreen()),
                  );
                }
                 break;
              case 'admin':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminFirstpage()),
                  );
                }

                break;
            }
          });
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Icon(Icons.work_outline,
                    size: 40, color: Colors.green[600]),
              ),
              Container(
                //  margin: const EdgeInsets.only(top: 8),
                child: Text(
                  'งาน',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, var page) {
    return Container(
      width: 130,
      height: 90,
      child: TextButton(
        onPressed: () {
          setState(
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          );
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Icon(icon, size: 40, color: Colors.green[600]),
              ),
              Container(
                //  margin: const EdgeInsets.only(top: 8),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listnews() {
    return FutureBuilder(
      future: getNews(),
      builder: (BuildContext context, AsyncSnapshot<NewsData> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              physics: ScrollPhysics(),
              itemCount: snapshot.data!.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    child: Column(children: [
                      Container(
                        width: double.infinity,
                        height: 170,
                        child: Image.network(
                          '${snapshot.data!.data![index].image}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildSeeMore(
                            ' ${snapshot.data?.data![index].detail}',
                          ),
                        )),
                      ),
                    ]),
                  ),
                );
              });
        } else {
          return Text('ไม่สามารถโหลดข้อมูลได้');
        }
      },
    );
  }

  Widget buildSeeMore(var text) {
    return SeeMore(
      text: text,
    );
  }
}

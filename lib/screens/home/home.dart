import 'package:animal_welfare/api/movieApi.dart';
import 'package:animal_welfare/model/movie.dart';
import 'package:animal_welfare/screens/calender/even.dart';
import 'package:animal_welfare/screens/FilterAllAnimal.dart';
import 'package:animal_welfare/screens/home/hotNews.dart';
import 'package:animal_welfare/screens/repair/repair_Page.dart';

import 'package:animal_welfare/screens/role/Aanimal%20caretaker/caretaker_fristpage.dart';
import 'package:animal_welfare/screens/role/breeder/breeder_firstpage.dart';
import 'package:animal_welfare/screens/role/researcher/research_firstPage.dart';
import 'package:animal_welfare/screens/role/showMan/schedule.dart';
import 'package:animal_welfare/screens/role/veterinarian/vet_firstpage.dart';
import 'package:animal_welfare/widget/seemore.dart';
import 'package:flutter/material.dart';
import 'package:animal_welfare/haxColor.dart';
import '../../api/movieApi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  final String? firstName;

  const HomePage({Key? key, this.firstName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    MovieApi.getMovie();
    // getProfile();
    super.initState();
  }

  // Future getProfile() async {
  //   String? token = await storage.read(key: 'token');
  //   print('can get token: $token');
  //   print('${widget.firstName}');
  // }

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
                              '??????????????????',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              '${widget.firstName}',
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
              _buildButton(Icons.timer, '??????????????????????????????????????????', Scaffold()),
              _buildButton(
                  Icons.calendar_today, '???????????????????????????????????????', CalendarScreen()),
              _buildButton(
                  Icons.assistant_photo_outlined, '???????????????????????????????????????', Scaffold()),
              _buildButton(Icons.settings, '?????????????????????', Scaffold()),
              _buildButton(Icons.build_outlined, '????????????????????????', RepairPage()),
              _buildButton(Icons.work_outline, '???????????????????????????', VetFirstpage()),
              _buildButton(
                  Icons.work_outline, '????????????????????????', ResearcherFirstpage()),
              _buildButton(
                  Icons.work_outline, '???????????????????????????????????????', BreederFirstpage()),
              _buildButton(
                  Icons.work_outline, '??????????????????????????????????????????', ScheduleScreen()),
              _buildButton(
                  Icons.work_outline, '????????????????????????????????????', CaretakerFirstPage()),
              _buildButton(Icons.work_outline, '???????????????????????????', FilterAnimalData()),
              // _buildButton(Icons.work_outline, '????????????', Scaffold()),
            ],
          ),
        ]),
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
    return FutureBuilder<MovieData>(
      builder: (BuildContext context, AsyncSnapshot<MovieData> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              physics: ScrollPhysics(),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    child: Column(children: [
                      Container(
                        width: double.infinity,
                        height: 170,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/bg1.png',
                          image: '${snapshot.data?.search[index].poster}',
                          fit: BoxFit.fill,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image(image: AssetImage('assets/bg1.png'));
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildSeeMore(
                            ' ${snapshot.data?.search[index].title}',
                          ),
                        )),
                      ),
                    ]),
                  ),
                );
              });
        } else {
          return Text('??????????????????????????????????????????????????????????????????');
        }
      },
      future: MovieApi.getMovie(),
    );
  }

  Widget buildSeeMore(var text) {
    return SeeMore(
      text: text,
    );
  }
}

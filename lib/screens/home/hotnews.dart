import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animal_welfare/constant.dart';
import 'package:animal_welfare/model/news.dart';
import 'package:animal_welfare/screens/home/hotnewsdetail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class HotnewsSlider extends StatefulWidget {
  @override
  _HotnewsSliderState createState() => _HotnewsSliderState();
}

class _HotnewsSliderState extends State<HotnewsSlider> {
  final storage = new FlutterSecureStorage();

Future<NewsData> getNews() async {
    String? token = await storage.read(key: 'token');
    String endPoint = Constant().endPoint;
    var response = await http.get(Uri.parse('$endPoint/api/getNews/1'),
        headers: {"authorization": 'Bearer $token'});
    //print(response.body);
    var jsonData = NewsData.fromJson(jsonDecode(response.body));
    //print(jsonData);
    return jsonData;
  }
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: double.infinity,
        child: FutureBuilder<NewsData>(
          future: getNews(),
          builder:
              (BuildContext context, AsyncSnapshot<NewsData> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return Container(
                child: Stack(
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200.0,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        reverse: false,
                      ),
                      items: snapshot.data!.data!.toList().map((imageUrl) {
                        return Builder(builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                            child: Image.network(
                              imageUrl.image.toString(),
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
                          );
                        });
                      }).toList(),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  HotNewsDetail(
                                      getNews: snapshot.data!.data!.toList().elementAt(_current), 
                                          
                                          
                                    )),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: snapshot.data!.data!.toList().asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return new Center(child: new CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

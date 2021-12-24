
import 'package:animal_welfare/model/hotNews.dart';
import 'package:animal_welfare/screens/home/hotnewsdetail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Slider extends StatefulWidget {
  const Slider({Key? key}) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  void initState() {
    super.initState();
  }

  int index = 1;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: double.infinity,
        child: FutureBuilder<List<ImageList>>(
   //       future: getSponsorSlide(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ImageList>> snapshot) {
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
                      items: snapshot.data!.toList().map((imageUrl) {
                        return Builder(builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                            child: Image.network(
                              imageUrl.images,
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
                                builder: (context) => HotNewsDetail(
                                      getimage: snapshot.data!
                                          .toList()
                                          .elementAt(_current),
                                    )),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: snapshot.data!
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
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

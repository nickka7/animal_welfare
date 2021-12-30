import 'package:animal_welfare/model/news.dart';
import 'package:flutter/material.dart';

class HotNewsDetail extends StatefulWidget {
  final Data getNews;
  const HotNewsDetail({
    Key? key,
    required this.getNews,
  }) : super(key: key);

  @override
  _HotNewsDetailState createState() => _HotNewsDetailState();
}

class _HotNewsDetailState extends State<HotNewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'หัวข้อ',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/bg1.png',
                image: '${widget.getNews.image}',
                fit: BoxFit.fill,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image(image: AssetImage('assets/bg1.png'));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('    ${widget.getNews.title}',style: TextStyle(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('    ${widget.getNews.detail}'),
            )
          ],
        ),
      ),
    );
  }
}

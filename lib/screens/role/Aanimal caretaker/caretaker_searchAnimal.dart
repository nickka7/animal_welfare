import 'package:animal_welfare/api/bookApi.dart';
import 'package:animal_welfare/haxColor.dart';
import 'package:animal_welfare/model/book.dart';
import 'package:animal_welfare/screens/role/Aanimal%20caretaker/caretaker_animalData.dart';
import 'package:animal_welfare/widget/search_widget.dart';
import 'package:flutter/material.dart';

class SearchAnimalData extends StatefulWidget {
  const SearchAnimalData({Key? key}) : super(key: key);

  @override
  _SearchAnimalDataState createState() => _SearchAnimalDataState();
}

class _SearchAnimalDataState extends State<SearchAnimalData> {
  List<Book> books = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final books = await BooksApi.getBooks(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('ข้อมูลสัตว์'),
          centerTitle: true,
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
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
            children: [
              buildSearch(),
              buildBook(),
            ],
          ),
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "ชื่อสัตว์,รหัสสัตว์,ชนิดของสัตว์",
        onChanged: searchBook,
      );

  Future searchBook(String query) async {
    final books = await BooksApi.getBooks(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.books = books;
    });
  }

  Widget buildBook() => ListView.builder(
      itemCount: books.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        final book = books[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Card(
            elevation: 5,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnimalData()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 70,
                        width: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Animal ID : ${book.id}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ชนิด : ${book.title}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'ชื่อ : ${book.author}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        size: 40,
                      )
                    ],
                  ),
                )),
          ),
        );
      });
}

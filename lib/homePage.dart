
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/Widgets/cardWidget.dart';
import 'package:news/article.dart';
import 'details.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final apiKey = dotenv.env['API_KEY'];
  List<Article> articlesSearch = [];
  final dio = Dio();

  var search;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News App"),
          centerTitle: true,
          backgroundColor: Colors.redAccent.shade200,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              search = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search',
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () => fetchData(),
                          // Add this onPressed callback
                          icon: Icon(Icons.search)
                      )
                    ],
                  ),
                ],
              ),
            ),
            articlesSearch.isNotEmpty ? Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                interactive: true,
                trackVisibility: true,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: articlesSearch.map((article) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(article: article),
                            ),
                          );
                        },
                        child: Hero(
                          tag: article?.img ??
                              "https://raw.githubusercontent.com/koehlersimon/fallback/master/Resources/Public/Images/placeholder.jpg",
                          child: CardWidget(img:article.img,title: article.title,description: article.description),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ) : Center(child: Container()),
          ],
        )
      /*: Center(child: CircularProgressIndicator()),*/
    );
  }


  Future<void> fetchData() async {
    articlesSearch = [];
    var url = "https://newsapi.org/v2/everything?q=$search&from=2023-10-08&to=2023-10-08&sortBy=popularity&apiKey=$apiKey";
    var response = await dio.get(url);
    var results = response.data["articles"];

    for (var article in results) {
      Article p = Article(description: article['description'],
          content: article['content'],
          link: article["url"],
          id: article['source']['id'],
          title: article['source']['name'],
          img: article['urlToImage'],
          author: article['author']);
      articlesSearch.add(p);
    }
    setState(() {});
  }

}

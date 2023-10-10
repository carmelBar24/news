

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:news/Widgets/gridElementWidget.dart';
import 'package:news/article.dart';
import 'NewsBloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final apiKey = dotenv.env['API_KEY'];
  final NewsBloc newsBloc = NewsBloc();
  DateTime startDate=DateTime.now();
  DateTime endDate=DateTime.now();
  var search;
  var error="";
  bool loading=false;

  @override
  void dispose() {
    newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showDatePicker(BuildContext context,date) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != date) {
        setState(() {
          if(date=="start")
          {
            startDate = picked;
          }
          else{
            endDate=picked;
          }
        });
      }
    }

    @visibleForTesting
    searchHandler(){
      try {
        setState(() {
          error="";
        });
        if (search==null) {
          throw ('Search cannot be empty');
        }

        if (search.contains(RegExp(r'\d'))) {
          throw(
              'Search cannot contain numbers');
        }

        if (startDate.isAfter(endDate)) {
          throw (
              'Start date must be before end date');
        }
        setState(() {
          loading = true;
        });

        newsBloc.fetchArticles(
            search, apiKey!, startDate, endDate).then((
            _) {
          setState(() {
            loading = false;
          });
        });
      }
      catch(e)
      {
        setState(() {
          error=e.toString();
        });
      }
    }
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
                          onPressed:searchHandler,
                          icon: Icon(Icons.search))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showDatePicker(context,"start");
                        },
                        child: Text("Pick Start Date",style: TextStyle(color: Colors.black)),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            _showDatePicker(context,"end");
                          },
                          child: Text("Pick end Date",style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder<List<Article>>(
              stream: newsBloc.articlesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Article> articlesSearch = snapshot.data!;
                  if(articlesSearch.isNotEmpty){
                  return Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 10,
                      interactive: true,
                      trackVisibility: true,
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: articlesSearch.map((article) {
                          return GridElementWidget(article: article);
                        }).toList(),
                      ),
                    ),
                  );}
                  else{
                    return Column(
                      children: [
                      Text("Nothing Here..",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Container(height: MediaQuery.of(context).size.height*0.5,child: Lottie.asset('assets/empty.json'))
                      ],
                    );
                  }
                } else if (!loading) {
                  return Center(child: Container(
                    child: Text(error),
                  ));
                } else {
                  return Center(child: CircularProgressIndicator(color: Colors.red,));
                }
              },
            ),
          ],
        )
        );
  }
}


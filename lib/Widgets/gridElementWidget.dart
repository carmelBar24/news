import 'package:flutter/material.dart';
import 'package:news/details.dart';

import 'cardWidget.dart';

class GridElementWidget extends StatelessWidget {
  var article;

  GridElementWidget({this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Details(article: article),
            ),
          );
        },
        child: Hero(
          tag: article?.img ??
              "https://raw.githubusercontent.com/koehlersimon/fallback/master/Resources/Public/Images/placeholder.jpg",
          child: CardWidget(
              img: article.img,
              title: article.title,
              description: article.description),
        ),
      ),
    );
  }
}

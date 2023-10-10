import 'package:flutter/material.dart';
import 'package:news/article.dart';


import 'Widgets/bodyWidget.dart';

class Details extends StatelessWidget {
  final Article article;
  Details({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100,
        elevation: 0,
      ),
      body:bodyWidget(article: article),
      backgroundColor: Colors.redAccent.shade100,
    );
  }
}

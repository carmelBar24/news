import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../article.dart';

class bodyWidget extends StatelessWidget {
  final Article article;

  bodyWidget({required this.article});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height/1.5,
          width: MediaQuery.of(context).size.width-20,
          left: 10.0,
          top:MediaQuery.of(context).size.height*0.1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height:100.0,),
                Text(article.title,style:TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
                ),
                ),
                Text(article.content),
                TextButton(onPressed: () => _launchUrl(Uri.parse(article.link)), child:Text("press"))

              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child:Hero(
            tag: article.img,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(article.img), fit: BoxFit.cover)
              ),
            ),
          ) ,
        )
      ],
    );
  }
  Future<void> _launchUrl(Uri uri) async {
    String url = uri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

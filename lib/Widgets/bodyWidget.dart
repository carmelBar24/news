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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(article.content,style: TextStyle(fontSize: 15)),
                ),
                TextButton(onPressed: () => _launchUrl(article.link), child:Text("Article Link",style: TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.redAccent.shade200), elevation: MaterialStatePropertyAll(3)),)

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
}

_launchUrl(link) async {
  if (!await canLaunch(link)){
    await launch(
      link,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $link';
  }
}

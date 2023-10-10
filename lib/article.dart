
import 'package:dio/dio.dart';
final dio = Dio();

class Article{
  var title;
  var author;
  var img;
  var id;
  var content;
  var link;
  var description;

  Article({this.description,this.title,this.author,this.img,this.id,this.content,this.link});

}
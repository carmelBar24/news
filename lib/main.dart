import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'homePage.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(
    MaterialApp(
      title: "Poke App",
      home:HomePage(),
      debugShowCheckedModeBanner: false,
    )
  );
}


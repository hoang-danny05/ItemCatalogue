//import 'dart:html';
//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

//root of application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Startup Name Generator",
      //main body of the app
      home: Scaffold(
        appBar: AppBar(
          title: const Text("D&D Item Catalouge"),
        ),
        body: const CatalougeView(),
      ),
    );
  }
}

class CatalougeView extends StatelessWidget {
  const CatalougeView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemNames = ["Shortsword", "Daggers", "Shield", "Healing Potion"];
    return ListView(children: [
      Text(itemNames[0]),
      Text(itemNames[1]),
      Text(itemNames[2]),
      Text(itemNames[3]),
    ]);
  }
}

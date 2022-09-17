//import 'dart:html';
//import 'package:english_words/english_words.dart';var
import 'package:flutter/material.dart';
import 'ItemClass.dart';

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
    final List<GameItem> itemList = GameItem.Setup();

    return ListView.builder(
        itemCount: itemList.length * 2,
        itemBuilder: ((context, index) {
          if (index.isOdd) {
            return const Divider();
          }
          final newIndex = index ~/ 2;
          return ListTile(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(itemList[newIndex].name),
              itemList[newIndex].rarity,
            ]),
            trailing: const Icon(Icons.list),
          );
        }));
  }
}

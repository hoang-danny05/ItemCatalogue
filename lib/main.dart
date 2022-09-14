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
    //move declarations into a different class.
    const COMMON = Text(
      "Common",
      style: TextStyle(fontStyle: FontStyle.italic),
      textAlign: TextAlign.left,
    );
    const UNCOMMON = Text(
      "Uncommon",
      style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
      textAlign: TextAlign.left,
    );
    final itemRarities = [COMMON, COMMON, COMMON, UNCOMMON];
    return ListView.builder(
        itemCount: itemNames.length * 2,
        itemBuilder: ((context, index) {
          if (index.isOdd) {
            return const Divider();
          }
          final newIndex = index ~/ 2;
          return ListTile(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(itemNames[newIndex]),
              itemRarities[newIndex],
            ]),
            trailing: const Icon(Icons.list),
          );
        }));
  }
}

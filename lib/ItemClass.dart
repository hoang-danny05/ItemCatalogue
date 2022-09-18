import 'package:flutter/material.dart';

class GameItem {
  GameItem(
      {this.name: "",
      this.rarity: const Text(""),
      this.description: "",
      this.damage: 0,
      this.cost: 0});

  //static constants
  static const COMMON = Text(
    "Common",
    style: TextStyle(fontStyle: FontStyle.italic),
    textAlign: TextAlign.left,
  );
  static const UNCOMMON = Text(
    "Uncommon",
    style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
    textAlign: TextAlign.left,
  );
  //static variables
  static List<GameItem> items = [];
  static bool isSetup = false;
  //static methods
  static GameItem hasName(String name) {
    if (isSetup == false) Setup();
    for (int i = 0; i < items.length; i++) {
      if (items[i].name == name) return items[i];
    }
    throw (IndexError);
  }

  static List<GameItem> Setup() {
    if (isSetup) return items;
    //initialize stuff here
    final itemNames = ["Shortsword", "Daggers", "Shield", "Healing Potion"];
    final descriptions = [
      "A standard Adventurer's sword.",
      "Light and sharp, these blades are made for the cunning or quick.",
      "Being heavy and sturdy, this shield is made to take many hits.",
      "Red and sweet, this concotion is made to heal the drinker's wounds up.",
    ];
    final itemRarities = [COMMON, COMMON, COMMON, UNCOMMON];
    final damageList = [10, 7, 0, -15];
    final costs = [50, 30, 75, 60];
    for (int i = 0; i < 4; i++) {
      items.add(GameItem(
          name: itemNames[i],
          rarity: itemRarities[i],
          description: descriptions[i],
          damage: damageList[i],
          cost: costs[i]));
    }
    isSetup = true;
    return items;
  }

  //attributes or properties
  late final String name, description;
  late final Text rarity;
  late final int damage, cost;
}

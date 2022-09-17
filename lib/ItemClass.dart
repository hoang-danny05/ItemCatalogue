import 'package:flutter/material.dart';

class GameItem {
  GameItem(this.name, this.rarity, this.description, this.damage, this.cost);

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
  //static methods
  static List<GameItem> Setup() {
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
    List<GameItem> returnList = <GameItem>[];
    for (int i = 0; i < 4; i++) {
      returnList.add(GameItem(itemNames[i], itemRarities[i], descriptions[i],
          damageList[i], costs[i]));
    }
    return returnList;
  }

  //attributes or properties
  late final String name, description;
  late final Text rarity;
  late final int damage, cost;
}

import 'package:flutter/material.dart';

class GameItem {
  GameItem({
    this.name: "",
    this.rarity: const Text(""),
    this.description: "",
    this.damage: 0,
    this.cost: 0,
    this.imageUrl = '/assets/nullimage.jpg',
  });

  //static constants
  static const _common = Text(
    "Common",
    style: TextStyle(fontStyle: FontStyle.italic),
    textAlign: TextAlign.left,
  );
  static const _uncommon = Text(
    "Uncommon",
    style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
    textAlign: TextAlign.left,
  );
  static const _rare = Text(
    "Rare",
    style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
    textAlign: TextAlign.left,
  );
  static const _legendary = Text(
    "Legendary",
    style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
    textAlign: TextAlign.left,
  )
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
    const itemNames = [
      "Shortsword",
      "Daggers",
      "Shield",
      "Healing Potion",
      "Force Plate Armor"
    ];
    const descriptions = [
      "A standard Adventurer's sword.",
      "Light and sharp, these blades are made for the cunning or quick.",
      "Being heavy and sturdy, this shield is made to take many hits.",
      "Red and sweet, this concotion is made to heal the drinker's wounds up.",
      "This set of half-plate has a special ability. At the user's will, they may force any enemies nearby 10 feet away.",
    ];
    const imageLinks = [
      './lib/assets/shortsword.png',
      './lib/assets/Dagger.png',
      './lib/assets/shield.png',
      './lib/assets/healingpotion.png',
      './lib/assets/halfplate.jpeg',
    ];
    const itemRarities = [_common, _common, _common, _uncommon, _rare];
    const damageList = [10, 7, 0, -15, 10];
    const costs = [50, 30, 75, 60, 500];
    for (int i = 0; i < itemNames.length; i++) {
      items.add(GameItem(
          name: itemNames[i],
          rarity: itemRarities[i],
          description: descriptions[i],
          damage: damageList[i],
          cost: costs[i],
          imageUrl: imageLinks[i]));
    }
    isSetup = true;
    return items;
  }

  //attributes or properties
  late final String name, description, imageUrl;
  late final Text rarity;
  late final int damage, cost;
}

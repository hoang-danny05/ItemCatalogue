import 'dart:html';

import 'package:flutter/material.dart';
import 'ItemClass.dart';

void main() => runApp(CatalogueApp());

//root of application
class CatalogueApp extends StatelessWidget {
  //const CatalogueApp({super.key});
  final CatalogueRouterDelegate _routerDelegate =
      CatalogueRouterDelegate(GlobalKey<NavigatorState>());
  final CatalogueRouteInformationParser _routeInformationParser =
      CatalogueRouteInformationParser();

  CatalogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Startup Name Generator",
      //goes from app state to navigator state
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

//abstract data type that is passed for navigation. Tells us what state we are in.
class CatalogueRoutePath {
  final GameItem? item;
  final bool isUnknown;

  //default page
  CatalogueRoutePath.home()
      : item = null,
        isUnknown = false;
  //details page
  CatalogueRoutePath.details(this.item) : isUnknown = false;
  //404 error
  CatalogueRoutePath.unknown()
      : item = null,
        isUnknown = true;

  //bools
  bool get isHomePage => item == null;

  bool get isDetailsPage => item != null;
}

//   static Scaffold home() { //default page of user
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("D&D Item Catalouge"),
//         ),
//         body: const CatalougeView(),
//       );
//   }
//   static Scaffold details(GameItem item) { //details of an item

//   }
// }
// parse route
class CatalogueRouteInformationParser
    extends RouteInformationParser<CatalogueRoutePath> {
  @override
  Future<CatalogueRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final url = Uri.parse(routeInformation.location ?? '/');

    // Handle '/'
    if (url.pathSegments.length == 0) {
      return CatalogueRoutePath.home();
    }

    if (url.pathSegments.length == 2) {
      if (url.pathSegments[0] != 'item') return CatalogueRoutePath.unknown();
      String id = url.pathSegments[1];
      try {
        return CatalogueRoutePath.details(GameItem.hasName(id));
      } catch (e) {
        return CatalogueRoutePath.unknown();
      }
    }
    return CatalogueRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(CatalogueRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/item/${path.item!.name}');
    }
    return RouteInformation(location: '/');
  }
}

//router delagate
class CatalogueRouterDelegate extends RouterDelegate<CatalogueRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<CatalogueRoutePath> {
  CatalogueRouterDelegate(this.navigatorKey);

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  GameItem? _selectedItem; //internal state
  bool show404 = false;

  final List<GameItem> _items = GameItem.Setup();

  //make route path
  CatalogueRoutePath get currentConfiguration {
    if (show404) {
      return CatalogueRoutePath.unknown();
    }
    return _selectedItem == null
        ? CatalogueRoutePath.unknown()
        : CatalogueRoutePath.details(_selectedItem);
  }

//implement function of making app state => navigator state
  @override
  Widget build(BuildContext context) {
    _onPopPage(Route route, dynamic result) {
      if (!route.didPop(result)) {
        return false;
      }

      //update list of pages by setting no selected item
      _selectedItem = null;
      show404 = false;
      notifyListeners();

      return true;
    }

    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: CatalougeView(
            onTapped: _handleItemTapped, //gives item handler funciton
          ),
        ),
        if (show404)
          const MaterialPage(
              key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedItem != null)
          MaterialPage(
              key: ValueKey('${_selectedItem}'),
              child: ItemDetailsPage(item: _selectedItem!))
      ],
      onPopPage: _onPopPage,
    );
  }

  //future tells us if we should make a 404 screen or not
  @override
  Future<void> setNewRoutePath(CatalogueRoutePath configuration) async {
    if (configuration.isUnknown) {
      _selectedItem = null;
      show404 = true;
      return;
    }

    if (configuration.isDetailsPage && configuration.item != null) {
      show404 = false;
      _selectedItem = configuration.item;
    } else {
      _selectedItem = null;
    }
    show404 = false;
  }

  void _handleItemTapped(GameItem item) {
    _selectedItem = item;
    notifyListeners();
  }
}

//full scrollable view of the webpage
class CatalougeView extends StatelessWidget {
  const CatalougeView({super.key, required this.onTapped});
  final ValueChanged<GameItem> onTapped;

  @override
  Widget build(BuildContext context) {
    final List<GameItem> itemList = GameItem.Setup();

    return Scaffold(
      appBar: AppBar(
        title: const Text("D&D Item Catalogue"),
      ),
      body: ListView.builder(
          itemCount: itemList.length * 2,
          itemBuilder: ((context, index) {
            if (index.isOdd) {
              return const Divider();
            }
            final newIndex = index ~/ 2;
            return ListTile(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemList[newIndex].name),
                    itemList[newIndex].rarity,
                  ]),
              trailing: const Icon(Icons.list),
              onTap: () => onTapped(itemList[newIndex]),
            );
          })),
    );
  }
}

//view of 404 page
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("404 Error"),
      ),
    );
  }
}

//view of an item's details
class ItemDetailsPage extends StatelessWidget {
  GameItem item;
  ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        children: [
          item.rarity,
          Text(item.description),
          Text('Damage: ${item.damage}'),
          Text('Cost: ${item.cost} GP'),
        ],
      ),
    );
  }
}

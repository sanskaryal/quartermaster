import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quartermaster/household/globals.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';
import 'package:quartermaster/shoplist/create_ShoppingList.dart';
import 'package:quartermaster/shoplist/view_shoplists.dart';

class ViewShopLists extends StatefulWidget {
  // shopListInfo is shoplist array
  final List<String> shopListInfo;
  const ViewShopLists({Key? key, required this.shopListInfo}) : super(key: key);

  @override
  State<ViewShopLists> createState() => _ViewShopListsState();
}

class _ViewShopListsState extends State<ViewShopLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Lists"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: getTextWidgets(widget.shopListInfo, context),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/createShopList');
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

Widget getTextWidgets(List<String> strings, context) {
  return ListView(
      children: strings
          .map((slid) => Center(
              child: FutureBuilder<ShoppingLists>(
                  future: FireStoreService().getShopListInfo(slid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return createCard(snapshot.data, slid, context);
                    } else {
                      return const Text("");
                    }
                  })))
          .toList());
}

Widget createCard(sl, slid, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {
          Global.setslid(slid);
          inspect(slid);
          Navigator.pushNamed(context, '/viewShoppingItems');        
        },
        child: Text(sl.name),
      ),
    ),
  );
}

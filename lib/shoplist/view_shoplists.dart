import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/household/globals.dart';
import 'package:quartermaster/services/models.dart';
import 'package:quartermaster/shoplist/create_shoppingList.dart';
import 'package:quartermaster/shoplist/shoplist_home.dart';

class ShopListHomeScreen extends StatelessWidget {
  const ShopListHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Households>(
        future: FireStoreService().getHouseholdInfo(Global.gethhid()),
        builder: (context, snapshot) {
          debugPrint("ShopListHomeScreen rendered");
          if (snapshot.hasData) {
            if ((snapshot.data!.shoppingList.isEmpty)) {
              return const SHomeNoSL();
            } else {
              return ViewShopLists(shopListInfo: snapshot.data!.shoppingList);
            }
          } else {
            return const ProgressIndicator();
          }
        });
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

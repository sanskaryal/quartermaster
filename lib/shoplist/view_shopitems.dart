import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
import 'package:quartermaster/shoplist/view_shoplists.dart';

class ViewShopItems extends StatelessWidget {
  const ViewShopItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("View Shop Items")),
        body: FutureBuilder<List<ShoppingItems>>(
          future: FireStoreService().getShopItemsName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 100,
                    color: Colors.lightBlue,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                snapshot.data![index].itemName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Text(''),
              );
            }
            return const Text("No items");
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const ShopListHomeScreen())));
          },
          tooltip: 'Done',
          label: const Text("Done"),
          icon: const Icon(Icons.check),
        ));
  }
}

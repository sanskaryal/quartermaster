import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/shoplist/view_shopitems.dart';
import 'package:quartermaster/shoplist/view_shoplists.dart';
import '../shared/bottom_navbar.dart';
import 'package:quartermaster/household/globals.dart';

//Create a new shoplist

class CreateShopList extends StatefulWidget {
  const CreateShopList({Key? key}) : super(key: key);

  @override
  State<CreateShopList> createState() => _CreateShopListState();
}

class _CreateShopListState extends State<CreateShopList> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // shoplist fields
  String name = "";
  String household = Global.gethhid();
  static List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Shopping List")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a shopping list name.';
                  } else {
                    name = value;
                    debugPrint(name);
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.shopping_cart,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Enter the name for your shopping list'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                child: const Text('Create Shopping List'),
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    FireStoreService()
                        .createShoppingLists(name, household, items);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShopListHomeScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  const ShoppingItem({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ShoppingItem> {
  final List<String> itemList = <String>[];
  String itemName = '';

  TextEditingController nameController = TextEditingController();
  bool status = false;
  String shopListID = Global.getslid();

  void addItemToList() {
    if (nameController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot be empty. Please try again.')));
    }
    if (nameController.value.text.isNotEmpty) {
      setState(() {
        itemList.insert(0, nameController.text);
        itemName = nameController.text;
        FireStoreService().ShoppingListItems(itemName, status, shopListID);
        nameController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Items'),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(),
                labelText: 'Shopping Item Name',
              ),
            ),
          ),
          ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                addItemToList();
              }),
          const SizedBox(
            height: 15.0,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recently added items are shown below:',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = itemList[index];
                    return Container(
                      height: 30,
                      margin: const EdgeInsets.all(2),
                      child: Text(
                        '•  ' '$item',
                        style:
                            const TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    );
                  })),
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const ViewShopItems())));
          },
          tooltip: 'View Shopping Items',
          label: const Text("View All Shopping Items"),
          icon: const Icon(Icons.view_list_outlined),
        ));
  }
}

class SHomeNoSL extends StatelessWidget {
  const SHomeNoSL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
                'You do not have any shopping lists. Tap the (+) sign to create a shopping list!'),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateShopList()));
        },
        tooltip: 'Create new Shopping List',
        child: const Icon(Icons.add),
      ),
    );
  }
}

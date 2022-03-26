import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
// import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';

class ViewHouseHolds extends StatefulWidget {
  final a = 5;
  // userinfo is household array
  final List<String> userInfo;
  const ViewHouseHolds({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<ViewHouseHolds> createState() => _ViewHouseHoldsState();
}

class _ViewHouseHoldsState extends State<ViewHouseHolds> {
  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.userInfo.elementAt(1));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Households"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: getTextWidgets(widget.userInfo),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

Widget getTextWidgets(List<String> strings) {
  return ListView(
      children: strings
          .map((hhid) => Center(
              child: FutureBuilder<Households>(
                  future: FireStoreService().getHouseholdInfo(hhid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      debugPrint(snapshot.data!.name + "aa");
                      return createCard(snapshot.data);
                    } else {
                      return const Text("");
                    }
                  })))
          .toList());
}

Widget createCard(hhid) {
  inspect(hhid.name);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
        height: 50,
        width: double.maxFinite,
        child: ElevatedButton(onPressed: () => {}, child: Text(hhid.name))),
  );
}

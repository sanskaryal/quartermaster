import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
// import 'package:quartermaster/services/firestore.dart';
// import 'package:quartermaster/shared/bottom_navbar.dart';

class ViewChores extends StatefulWidget {
  final a = 5;
  // userinfo is household array
  final List<String> choreInfo;
  const ViewChores({Key? key, required this.choreInfo}) : super(key: key);

  @override
  State<ViewChores> createState() => _ViewChoresState();
}

class _ViewChoresState extends State<ViewChores> {
  @override
  Widget build(BuildContext context) {
    //debugPrint(widget.choreInfo.elementAt(1));
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Chores"),
        //automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: getTextWidgets(widget.choreInfo),
      ),
      //bottomNavigationBar: const BottomNavBar(),
    );
  }
}

Widget getTextWidgets(List<String> strings) {
  return ListView(
      children: strings
          .map((choreID) => Center(
              child: FutureBuilder<Chores>(
                  future: FireStoreService().getChoreInfo(choreID),
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

Widget createCard(choreID) {
  inspect(choreID.name);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
        height: 50,
        width: double.maxFinite,
        child: ElevatedButton(onPressed: () => {}, child: Text(choreID.name))),
  );
}

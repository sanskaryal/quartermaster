import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
// import 'package:quartermaster/services/firestore.dart';
// import 'package:quartermaster/shared/bottom_navbar.dart';

class ViewAllChores extends StatefulWidget {
  // userinfo is household array
  final List<String> choreInfo;
  const ViewAllChores({Key? key, required this.choreInfo}) : super(key: key);

  @override
  State<ViewAllChores> createState() => _ViewAllChoresState();
}

class _ViewAllChoresState extends State<ViewAllChores> {
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

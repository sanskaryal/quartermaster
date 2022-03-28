import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quartermaster/household/globals.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';

import '../shared/bottom_navbar.dart';

class ViewChores extends StatelessWidget {
  const ViewChores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Chores"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<Households>(
          future: FireStoreService().getHouseholdInfo(Global.gethhid()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.chores.isNotEmpty) {
                return ViewChoresforUser(choreInfo: snapshot.data!.chores);
              }
            }
            debugPrint(Global.gethhid());
            return const Center(
                child: const Text("You have no Chores! Enjoy!!!"));
          }),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class ViewChoresforUser extends StatefulWidget {
  final List<String> choreInfo;
  const ViewChoresforUser({Key? key, required this.choreInfo})
      : super(key: key);

  @override
  State<ViewChoresforUser> createState() => _ViewChoresforUserState();
}

class _ViewChoresforUserState extends State<ViewChoresforUser> {
  @override
  Widget build(BuildContext context) {
    return getTextWidgets(widget.choreInfo, context);
  }
}

Widget getTextWidgets(List<String> strings, context) {
  return ListView(
      children: strings
          .map((hhid) => Center(
              child: FutureBuilder<Chores>(
                  future: FireStoreService().getChoreInfo(hhid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      debugPrint(snapshot.data!.name + "aa");
                      return createCard(snapshot.data, hhid, context);
                    } else {
                      return const Text("aa");
                    }
                  })))
          .toList());
}

Widget createCard(chore, cid, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {
          Global.sethhid(cid);
          inspect(cid);
          Navigator.pushNamed(context, '/viewChore');
          // inspect(hhid);
        },
        child: Text(chore.name),
      ),
    ),
  );
}

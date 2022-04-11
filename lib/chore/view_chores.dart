import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quartermaster/chore/view_all_chores.dart';
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
            return const Center(child: Text("You have no Chores! Enjoy!!!"));
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FutureBuilder(
              future: FireStoreService().getHouseholdInfo(Global.gethhid()),
              builder: (context, AsyncSnapshot<Households> snapshot) {
                if (snapshot.hasData) {
                  debugPrint("snapshot has data");
                  return FloatingActionButton(
                      heroTag: "show_all_chores",
                      child: const Icon(Icons.assignment_outlined),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllChores(
                                      choreInfo: snapshot.data!.chores,
                                    )));
                      });
                } else {
                  return FloatingActionButton(
                      heroTag: "error",
                      onPressed: () {
                        debugPrint("No data");
                      },
                      child: const Text("FAILURE"));
                }
              }),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              heroTag: "createChore",
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/createChore');
              })
        ],
      ),
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
                      if (snapshot.data!.member == Global.getuid()) {
                        return createCard(snapshot.data, hhid, context);
                      } else {
                        return const Text("");
                      }
                    } else {
                      return const Text("");
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
          // inspect(hhid);
        },
        child: Text(chore.name),
      ),
    ),
  );
}

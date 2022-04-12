import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quartermaster/household/globals.dart';
import 'package:quartermaster/services/auth.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
// import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';

class ViewHouseHolds extends StatefulWidget {
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
        child: getTextWidgets(widget.userInfo, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createHousehold');
        },
        tooltip: 'Create new HouseHold',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

Widget getTextWidgets(List<String> strings, context) {
  return ListView(
      children: strings
          .map((hhid) => Center(
              child: FutureBuilder<Households>(
                  future: FireStoreService().getHouseholdInfo(hhid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      debugPrint(snapshot.data!.name + "aa");
                      return createCard(snapshot.data, hhid, context);
                    } else {
                      return const Text("");
                    }
                  })))
          .toList());
}

Widget createCard(hh, hhid, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () async {
          String? userid = await AuthService().getUserId();
          Global.setuid(userid);
          Global.sethhid(hhid);
          inspect(hhid);
          Navigator.pushNamed(context, '/viewChore');
          // inspect(hhid);
        },
        child: Text(hh.name),
      ),
    ),
  );
}

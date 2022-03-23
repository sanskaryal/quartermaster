import 'package:flutter/material.dart';
import 'package:quartermaster/chore/home_hh.dart';
import 'package:quartermaster/chore/home_no_hh.dart';
import 'package:quartermaster/household/view_households.dart';
import 'package:quartermaster/profile/profile.dart';
import 'package:quartermaster/services/auth.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';

class ChoreHomeScreen extends StatelessWidget {
  const ChoreHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users>(
        future: FireStoreService().getUserInfo(),
        builder: (context, AsyncSnapshot<Users> snapshot) {
          debugPrint("chorehomescreen rendered");
          if (snapshot.hasData) {
            if ((snapshot.data!.houseHolds.isEmpty)) {
              return const CHomeNoHH();
            } else {
              return const ViewHouseHolds();
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

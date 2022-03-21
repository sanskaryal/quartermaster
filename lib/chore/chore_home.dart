import 'package:flutter/material.dart';
import 'package:quartermaster/chore/home_hh.dart';
import 'package:quartermaster/chore/home_no_hh.dart';
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
          if (snapshot.hasData) {
            if (snapshot.data!.houseHolds.isEmpty) {
              return const CHomeNoHH();
            } else {
              return const CHomeHH();
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

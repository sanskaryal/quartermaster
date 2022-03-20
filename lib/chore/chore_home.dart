import 'package:flutter/material.dart';
import 'package:quartermaster/chore/home_no_hh.dart';
import 'package:quartermaster/services/auth.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';

class ChoreHomeScreen extends StatelessWidget {
  const ChoreHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: AuthService().getUserId(),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<Users>(
                future: FireStoreService().getUserInfo(snapshot.toString()),
                builder: (context, user) {
                  return CHomeNoHH();
                });
          } else {
            return const CHomeNoHH();
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:quartermaster/chore/view_all_chores.dart';
import 'package:quartermaster/services/auth.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return FutureBuilder<String?>(
        future: AuthService().getUserId(),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Profile"),
              ),
              body: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        child: const Text("log me out"),
                        onPressed: () async {
                          await AuthService().signOut();
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                        },
                      ),
                      ElevatedButton(
                        child: Text("${snapshot.data}"),
                        onPressed: () {
                          debugPrint(snapshot.data);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      goToChores(),
                    ],
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: () {
                Navigator.pushNamed(context, '/createChore');
              }),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget goToChores() {
    return FutureBuilder(
        future: FireStoreService().getHouseholdInfo("create_chore_house"),
        builder: (context, AsyncSnapshot<Households> snapshot) {
          if (snapshot.hasData) {
            debugPrint("snapshot has data");
            return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewChores(
                                choreInfo: snapshot.data!.chores,
                              )));
                },
                child: const Text("All Chores"));
          } else {
            return ElevatedButton(
                onPressed: () {
                  debugPrint("No data");
                },
                child: const Text("FAILURE"));
          }
        });
  }
}

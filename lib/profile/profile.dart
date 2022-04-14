import 'package:flutter/material.dart';
import 'package:quartermaster/chore/view_all_chores.dart';
import 'package:quartermaster/services/auth.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Options")),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                ),
                child: const Text("LogOut"),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                ),
                child: const Text("Add Member to this Household"),
                onPressed: () async {
                  Navigator.pushNamed(context, '/addMember');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                ),
                child: const Text("Switch Household"),
                onPressed: () async {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
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
                          builder: (context) => ViewAllChores(
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

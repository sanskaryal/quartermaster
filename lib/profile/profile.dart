import 'package:flutter/material.dart';
import 'package:quartermaster/services/auth.dart';

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
              body: Row(
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
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

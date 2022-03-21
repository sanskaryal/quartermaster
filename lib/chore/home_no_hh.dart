import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';

import '../services/auth.dart';

class CHomeNoHH extends StatelessWidget {
  const CHomeNoHH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Center(
              child:
                  Text('You do not have a household. Create a household...')),
          ElevatedButton(
            child: const Text("log me out"),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

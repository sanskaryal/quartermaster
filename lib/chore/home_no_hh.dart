import 'package:flutter/material.dart';

import '../services/auth.dart';

class CHomeNoHH extends StatelessWidget {
  const CHomeNoHH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Center(
              child: const Text(
                  'You do not have a household. Create a household...')),
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
    );
  }
}

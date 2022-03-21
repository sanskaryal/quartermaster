import 'package:flutter/material.dart';

import '../shared/bottom_navbar.dart';

class CHomeHH extends StatelessWidget {
  const CHomeHH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

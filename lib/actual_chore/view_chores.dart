import 'package:flutter/material.dart';

import '../shared/bottom_navbar.dart';

class ViewChores extends StatelessWidget {
  const ViewChores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chores"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

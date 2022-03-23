import 'package:flutter/material.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';

class ViewHouseHolds extends StatefulWidget {
  const ViewHouseHolds({Key? key}) : super(key: key);

  @override
  State<ViewHouseHolds> createState() => _ViewHouseHoldsState();
}

class _ViewHouseHoldsState extends State<ViewHouseHolds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

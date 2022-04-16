import 'package:flutter/material.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';

class CHomeNoHH extends StatelessWidget {
  const CHomeNoHH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
                'You do not have any households. Tap the (+) sign to create one or have other members add you to a household!'),
          ),
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createHousehold');
        },
        tooltip: 'Create new HouseHold',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.tasks,
            size: 20,
          ),
          label: 'Chores',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.dollarSign,
            size: 20,
          ),
          label: 'Expenses',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.shoppingCart,
            size: 20,
          ),
          label: 'Shopping List',
        ),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            break;
          case 1:
            Navigator.pushNamed(context, '/expense');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}

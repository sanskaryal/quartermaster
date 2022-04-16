import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.tasks,
            size: 15,
          ),
          label: 'Chores',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.dollarSign,
            size: 15,
          ),
          label: 'Expenses',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.shoppingCart,
            size: 15,
          ),
          label: 'Shopping',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.user,
            size: 15,
          ),
          label: 'Options',
        ),
      ],
      fixedColor: Colors.black54,
      onTap: (int idx) {
        switch (idx) {
          case 0:
            Navigator.pushNamed(context, '/viewChore');
            break;
          case 1:
            Navigator.pushNamed(context, '/expense');
            break;
          case 2:
            Navigator.pushNamed(context, '/viewShopList');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}

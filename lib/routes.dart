import 'package:quartermaster/chore/chore_home.dart';
import 'package:quartermaster/chore/create_chore.dart';
import 'package:quartermaster/expense/expense_home.dart';
import 'package:quartermaster/home/home.dart';
import 'package:quartermaster/household/create_household.dart';
// import 'package:quartermaster/household/view_households.dart';
import 'package:quartermaster/login/login.dart';
import 'package:quartermaster/profile/profile.dart';
import 'package:quartermaster/shoplist/shoplist_home.dart';

var appRoutes = {
  '/': (context) => const HomepageScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/expense': (context) => const ExpenseHomeScreen(),
  '/chore': (context) => const HomeScreen(),
  '/shoplist': (context) => const ShopListHomeScreen(),
  '/createHousehold': (context) => CreateHousehold(),
  // '/viewHouseHolds': (context) => ViewHouseHolds(),
  '/createChore': (context) => const CreateChore(),
};

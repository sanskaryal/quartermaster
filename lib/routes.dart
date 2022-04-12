import 'package:quartermaster/chore/create_chore.dart';
import 'package:quartermaster/chore/view_chores.dart';
import 'package:quartermaster/expense/create_expense.dart';
import 'package:quartermaster/home/chore_home.dart';
// import 'package:quartermaster/expense/expense_home.dart';
import 'package:quartermaster/home/home.dart';
import 'package:quartermaster/household/add_member.dart';
import 'package:quartermaster/household/create_household.dart';
// import 'package:quartermaster/household/view_households.dart';
import 'package:quartermaster/login/login.dart';
import 'package:quartermaster/profile/profile.dart';
import 'package:quartermaster/shoplist/shoplist_home.dart';

var appRoutes = {
  '/': (context) => const HomepageScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  // '/expense': (context) => const ExpenseHomeScreen(),
  '/chore': (context) => const HomeScreen(),
  '/shoplist': (context) => const ShopListHomeScreen(),
  '/createHousehold': (context) => const CreateHousehold(),
  // '/viewHouseHolds': (context) => const ViewHouseHolds(userInfo: [],),
  '/createChore': (context) => const CreateChore(),
  '/viewChore': (context) => const ViewChores(),
  '/addMember': (context) => const AddMember(),
  '/createExpense': (context) => const CreateExpense(),
};

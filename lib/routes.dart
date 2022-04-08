import 'package:quartermaster/actual_chore/view_chores.dart';
import 'package:quartermaster/chore/chore_home.dart';
import 'package:quartermaster/actual_chore/create_chore.dart';
import 'package:quartermaster/expense/expense_home.dart';
import 'package:quartermaster/home/home.dart';
import 'package:quartermaster/household/create_household.dart';
import 'package:quartermaster/login/login.dart';
import 'package:quartermaster/profile/profile.dart';
import 'package:quartermaster/shoplist/create_shoppingList.dart';
import 'package:quartermaster/shoplist/view_shoplists.dart';

var appRoutes = {
  '/': (context) => const HomepageScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/expense': (context) => const ExpenseHomeScreen(),
  '/chore': (context) => const HomeScreen(),
  '/createShopList': (context) => const CreateShopList(),
  '/createHousehold': (context) => const CreateHousehold(),
  '/viewShopList': (context) => const ShopListHomeScreen(),
  '/viewShoppingItems': (context) => ShoppingItem(),
  '/createChore': (context) => const CreateChore(),
  '/viewChore': (context) => const ViewChores()
};

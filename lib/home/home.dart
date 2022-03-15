import 'package:flutter/material.dart';
import 'package:quartermaster/chore/chore_home.dart';
import 'package:quartermaster/login/login.dart';
import 'package:quartermaster/profile/profile.dart';
import 'package:quartermaster/services/auth.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          // goes to profile screen if logged in... just for development... later replace with ChoreHome
          return const ProfileScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

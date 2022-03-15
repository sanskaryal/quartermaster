import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../expense/expense_home.dart';
import '../../services/auth.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return AuthService().signIn(data.name, data.password);
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('signup Data: ${data.password}');
    return AuthService().signUp(data.name, data.password);
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'QuarterMaster',
      logo: const AssetImage('assets/images/qm_logo.png'),
      // Uncomment the following lines to add full name in the signup process
      // additionalSignupFields: const [
      //   UserFormField(keyName: "FirstName"),
      //   UserFormField(keyName: "LastName")
      // ],
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ExpenseHomeScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}

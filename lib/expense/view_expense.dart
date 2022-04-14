import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';

class ViewExpenses extends StatelessWidget {
  const ViewExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: FireStoreService().viewExpenses(),
          child: Text("View Expenses")),
    );
  }
}

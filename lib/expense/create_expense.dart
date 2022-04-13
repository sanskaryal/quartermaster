import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quartermaster/household/globals.dart';
import 'package:quartermaster/services/firestore.dart';

class CreateExpense extends StatefulWidget {
  const CreateExpense({Key? key}) : super(key: key);

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final String submitButtonLabel = "Create Expense";

  // expense field variables
  String title = "";
  String desc = "";
  double cost = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Expense")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // name field
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an expense title';
                  } else {
                    debugPrint(value);
                    title = value;
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name the new expense"),
              ),

              // description field (input optional)
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    desc = "No description";
                  } else {
                    desc = value;
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Describe the expense (purpose, items, etc.)"),
              ),

              // cost field (should allow numbers only)
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cost of the expense';
                  } else if (double.parse(value) <= 0) {
                    return 'Cost must be greater than 0';
                  } else {
                    cost = double.parse(value);
                  }
                },
                inputFormatters: [
                  // https://flutteragency.com/how-to-allow-only-two-decimal-number-in-flutter/
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "How much did it cost?"),
              ),

              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //
                      // needs to also take members[]
                      // ask Sanskar how that works if we're not letting user choose members
                      // currently uses .getHouseMemberIDs to return the list of all
                      // house members as the parameter.
                      await FireStoreService().createExpense(
                          Global.getuid(),
                          Global.gethhid(),
                          title,
                          desc,
                          cost,
                          await FireStoreService()
                              .getHouseMemberIDs(Global.gethhid()));

                      // navigate to view expenses screen
                    }
                  },
                  child: Text(submitButtonLabel))
            ],
          ),
        ),
      ),
    );
  }
}

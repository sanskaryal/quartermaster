import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quartermaster/household/globals.dart';
// import 'package:quartermaster/chore/chore_home.dart';
import 'package:quartermaster/services/firestore.dart';

// Create a Form widget.
class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  AddMemberState createState() {
    return AddMemberState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddMemberState extends State<AddMember> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Member")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email field cannot be empty';
                  } else {
                    //search and find  if the email exists and retrieve the uid
                    FireStoreService().addUidtoHH(value, Global.gethhid());
                    FireStoreService().addHidToUser(value, Global.gethhid());
                    //if the email exists then add the uid into the household table

                    //and then add the household id into the users table
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.home_filled,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    labelText: 'Enter an email to add to your household'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Person added to household')),
                      );
                      Navigator.pushNamed(context, '/chore');
                    }
                  },
                  child: const Text('Add User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: camel_case_types

/*
  Ryan Bearse
  
  This screen will be presented to the user to allow them to create new chore
  items for their currently selected household.

  It will receive the name of the chore as a String, the members assigned to
  the chore as a String array, and the frequency and due dates of the chore as
  DateTime objects.

  When the user presses the button to submit this data, it will all be saved 
  in Firestore, calling the createChore method and inputting the user data
  along with the household ID of the user's currently selected household. It
  will also add the choreID to the current household's chores array.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quartermaster/services/firestore.dart';

class CreateChore extends StatefulWidget {
  const CreateChore({Key? key}) : super(key: key);

  @override
  State<CreateChore> createState() => _createChoreState();
}

class _createChoreState extends State<CreateChore> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // text controllers
  //final choreNameController = TextEditingController();
  //final frequencyController = TextEditingController();

  // chore fields
  String choreName = "";
  String choreUser = "testUser";
  int frequency = 0;
  DateTime _myDateTime = DateTime(DateTime.now().year);
  String dateSelected = "";

  // label variables
  String dateButtonLabel = "Choose Start Date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Chore")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // chore name field
              TextFormField(
                //controller: choreNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a chore name.';
                  } else {
                    choreName = value;
                    debugPrint(choreName);
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                    labelText: 'Name the new chore'),
              ),

              // member selection fields
              //  -row of generated buttons?
              //  -drop down list?
              //  -ListView?

              // frequency field
              TextFormField(
                // found this code online.
                // https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter
                // username Bilal Simsek

                // It's supposed to limit the field to
                // only accept numbers from the user. It's also supposed to only
                // present the user with a number pad. I thought it would save us
                // some work in data validation.

                //controller: frequencyController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a frequency for the chore.';
                  } else {
                    int f = int.parse(value);

                    // optional. limits frequency to at least once per month
                    // not required for app function, just seemed like a
                    // good cutoff to reduce the work involved in any future
                    // calculations.
                    if (f < 1 || f > 31) {
                      return 'Invalid frequency. Must occur at least once/month.';
                    } else {
                      frequency = f;
                      debugPrint("$frequency");
                    }
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                    labelText: 'Choose the frequency of the chore'),
              ),

              // due date selection button
              ElevatedButton(
                onPressed: () async {
                  // display datePicker and save chosen date in _myDateTime
                  // if we want to limit what dates they can choose, we should
                  // be able to do that in here by modifying the firstDate
                  // and lastDate properties.
                  _myDateTime = await showDatePicker(
                    context: context,

                    // sets the initial date to the user's current date
                    initialDate: DateTime.now(),

                    // only allows dates to be selected up to the beginning of
                    // current year. Set to only in the present or future?
                    firstDate: DateTime(DateTime.now().year),

                    // max acceptable date is 1 year in the future
                    lastDate: DateTime(DateTime.now().year + 1),
                  ) as DateTime;
                  // apparently showDatePicker needed to be
                  // type cast. Tutorial didn't need it, but
                  // this seems to make the compiler happy.

                  setState(() {
                    final selection = _myDateTime.toString();
                    dateSelected = selection;
                  });
                },
                child: Text(dateButtonLabel),
              ),

              // submit button
              ElevatedButton(
                onPressed: () async {
                  debugPrint("Done Button Pressed");

                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    debugPrint(dateSelected);

                    FireStoreService().createChores(
                        choreName, choreUser, frequency, dateSelected);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chore Created')),
                    );
                  }
                },
                child: const Text("Create Chore"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

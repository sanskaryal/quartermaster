import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quartermaster/household/globals.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';

List<String> memberIDs = [];

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

  // user query future
  Future<List<Users>> houseUsers =
      FireStoreService().getHouseMembers(Global.gethhid());

  List<String> userNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Expense")),
      body: SingleChildScrollView(
        child: Form(
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
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "How much did it cost?"),
                ),

                FutureBuilder<List<Users>>(
                    future: houseUsers,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //isPressed = List.generate(snapshot.data!.length, (index) => false)
                        return SizedBox(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              // ignore: unnecessary_string_interpolations
                              //return Text('${snapshot.data![index].firstName}');
                              return StatefulButton(
                                  index: index, user: snapshot.data![index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: snapshot.data!.length,
                          ),
                        );
                      } else {
                        return const Text("Loading Users...");
                      }
                    }),

                //getMemberWidgets(),

                // submit button
                ElevatedButton(
                    onPressed: () async {
                      if (memberIDs.isNotEmpty) {
                        if (_formKey.currentState!.validate()) {
                          // List<String> ids = await FireStoreService()
                          //     .getHouseMemberIDs(Global.gethhid());

                          // ids.remove(Global.getuid());
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
                              memberIDs);
                          await FireStoreService().createOwes(cost, memberIDs,
                              Global.getuid(), Global.gethhid());

                          // navigate to view expenses screen

                          Navigator.pushNamed(context, '/expense');
                        }
                      }
                    },
                    child: Text(submitButtonLabel))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget getMemberWidgets() {
  //   return FutureBuilder(
  //       future: houseUsers,
  //       builder: (context, AsyncSnapshot<List<Users>> snapshot) {
  //         if (snapshot.hasData) {
  //           for (var user in snapshot.data!) {
  //             userNames.add(user.firstName);
  //           }
  //           return ListView.builder(
  //               itemCount: userNames.length,
  //               itemBuilder: (context, index) {
  //                 createMemberCard(snapshot.data!, userNames, context);
  //               });
  //         } else {
  //           return const Text("Loading Users...");
  //         }
  //       });
  // }

  // Widget createMemberCard(List<Users> users, List<String> names, context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: SizedBox(
  //       height: 50,
  //       width: double.maxFinite,
  //       child: ElevatedButton(onPressed: () async {}, child: Text("")),
  //     ),
  //   );
  // }
}

class StatefulButton extends StatefulWidget {
  final int index;
  final Users user;
  const StatefulButton({Key? key, required this.index, required this.user})
      : super(key: key);

  @override
  State<StatefulButton> createState() => _StatefulButtonState();
}

class _StatefulButtonState extends State<StatefulButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        textColor: Colors.white,
        color: isPressed ? Colors.amber : Colors.blue,
        onPressed: () {
          if (isPressed == false) {
            setState(() {
              isPressed = true;
              memberIDs.add(widget.user.uid);
              debugPrint(memberIDs.toString());
            });
          } else {
            setState(() {
              isPressed = false;
              memberIDs.remove(widget.user.uid);
              debugPrint(memberIDs.toString());
            });
          }
        },
        child: Text(widget.user.firstName));
  }
}

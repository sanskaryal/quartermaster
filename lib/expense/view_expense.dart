import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';
import 'package:quartermaster/shared/bottom_navbar.dart';

class ViewExpenses extends StatelessWidget {
  const ViewExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
      ),
      body: FutureBuilder<List<Expenses>>(
        future: FireStoreService().getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 150,
                  color: Colors.lightBlue,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              'EXPENSE NAME: ${snapshot.data![index].name}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              'COST: ${snapshot.data![index].cost}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: FutureBuilder<String>(
                                future: FireStoreService().getUserName(
                                    snapshot.data![index].creatorID),
                                builder: (context, ss) {
                                  if (ss.hasData) {
                                    return Text(
                                      'PAID BY: ${ss.data}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    );
                                  } else {
                                    return const Text('PAID BY:');
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }
          return const Text('There is no expense created');
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/createExpense'),
        child: Icon(Icons.add),
      ),
    );
  }
}

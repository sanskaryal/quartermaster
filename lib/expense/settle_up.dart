import 'package:flutter/material.dart';
import 'package:quartermaster/services/firestore.dart';
import 'package:quartermaster/services/models.dart';

class SettleUp extends StatelessWidget {
  const SettleUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settle Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // second person in document
            FutureBuilder<List<Owes>>(
                future: FireStoreService().getUserInWhom(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FutureBuilder<Object>(
                              future: FireStoreService()
                                  .getUserName(snapshot.data![index].who),
                              builder: (cxt, ss) {
                                String s;
                                double amt = snapshot.data![index].amount;
                                // check if negative
                                // if (amt < 0) {
                                //   s = (amt * -1).toStringAsFixed(2);
                                // } else {
                                //s = amt.toStringAsFixed(2);
                                // }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Text('You are owed \$$s by ${ss.data}'),
                                    whomWidget(amt, ss),
                                    ElevatedButton(
                                      child: Text('Settle Up'),
                                      onPressed: () {
                                        FireStoreService()
                                            .settleUp(snapshot.data![index].id);
                                        Navigator.pushNamed(
                                            context, '/expense');
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: snapshot.data!.length);
                  }
                  return Text("");
                }),
            SizedBox(height: 25),
            // first person in document
            FutureBuilder<List<Owes>>(
                future: FireStoreService().getUserInWho(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FutureBuilder<Object>(
                              future: FireStoreService()
                                  .getUserName(snapshot.data![index].whom),
                              builder: (cxt, ss) {
                                String s;
                                double amt = snapshot.data![index].amount;
                                // check if negative
                                // if (amt < 0) {
                                //   s = (amt * -1).toStringAsFixed(2);
                                // } else {
                                //s = amt.toStringAsFixed(2);
                                // }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Text('You owe \$$s to ${ss.data}'),
                                    whoWidget(amt, ss),
                                    ElevatedButton(
                                      child: Text('Settle Up'),
                                      onPressed: () {
                                        FireStoreService()
                                            .settleUp(snapshot.data![index].id);
                                        Navigator.pushNamed(
                                            context, '/expense');
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: snapshot.data!.length);
                  }
                  return Text("");
                }),
          ],
        ),
      ),
    );
  }

  // if second doc member is logged in, checks whether amount is negative
  // and outputs appropriate message
  Widget whomWidget(double amt, AsyncSnapshot<Object> ss) {
    String s;
    if (amt < 0) {
      amt *= -1;
      s = amt.toStringAsFixed(2);
      return Text('You owe \$$s to ${ss.data}');
    } else {
      s = amt.toStringAsFixed(2);
      return Text('You are owed \$$s by ${ss.data}');
    }
  }

  // if first doc member is logged in, checks whether amount is negative
  // and outputs appropriate message
  Widget whoWidget(double amt, AsyncSnapshot<Object> ss) {
    String s;
    if (amt < 0) {
      amt *= -1;
      s = amt.toStringAsFixed(2);
      return Text('You are owed \$$s by ${ss.data}');
    } else {
      s = amt.toStringAsFixed(2);
      return Text('You owe \$$s to ${ss.data}');
    }
  }
}

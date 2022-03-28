import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quartermaster/services/models.dart';
import 'auth.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var user = AuthService().user!;

  Future<void> createUsers(email) {
    var ref = _db.collection('Users').doc(user.uid);

    var data = {
      'email': email,
      'firstName': 'John',
      'lastName': 'Doe',
      'houseHolds': [],
    };
    return ref.set(data, SetOptions(merge: true));
  }

  Future<Users> getUserInfo() async {
    var ref = _db.collection('Users').doc(user.uid);
    var snapshot = await ref.get();
    return Users.fromJson(snapshot.data() ?? {});
  }

  Future<Households> getHouseholdInfo(hhid) async {
    var ref = _db.collection('Households').doc(hhid);
    var snapshot = await ref.get();
    return Households.fromJson(snapshot.data() ?? {});
  }

  Future<void> createHouseholds(name) {
    var ref = _db.collection('Households').doc();
    String houseHoldId = ref.id;

    var data = {
      'name': name,
      'chores': [],
      'expenses': [],
      'shoppingList': [],
      'users': FieldValue.arrayUnion([user.uid])
    };
    addHouseholdtoUser(houseHoldId);
    // add a function to update the household field on users table
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> addHouseholdtoUser(houseHoldId) {
    var ref = _db.collection('Users').doc(user.uid);

    var data = {
      'houseHolds': FieldValue.arrayUnion([houseHoldId])
    };

    // add a function to update the household field on users table
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> createChores(name, member, frequency, date) {
    var ref = _db.collection('Chores').doc();
    // String choreID = ref.id;

    var data = {
      'name': name,
      'member': member,
      'frequency': frequency,
      'dueDate': date
    };
    // how to get houseHoldID?
    // addChoreToHousehold(choreID, houseHoldID);

    return ref.set(data, SetOptions(merge: true));
  }

  Future<Chores> getChoreInfo(cid) async {
    var ref = _db.collection('Chores').doc(cid);
    var snapshot = await ref.get();
    return Chores.fromJson(snapshot.data() ?? {});
  }
}

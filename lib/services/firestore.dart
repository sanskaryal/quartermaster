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
}

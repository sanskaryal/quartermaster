import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quartermaster/services/models.dart';
import 'auth.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUsers(email) {
    var user = AuthService().user!;
    var ref = _db.collection('users').doc(user.uid);

    var data = {
      'email': email,
      'firstName': 'John',
      'lastName': 'Doe',
      'household': [],
    };
    return ref.set(data, SetOptions(merge: true));
  }

  Future<Users> getUserInfo(String uid) async {
    var ref = _db.collection('Users').doc(uid);
    var snapshot = await ref.get();
    return Users.fromJson(snapshot.data() ?? {});
  }
}

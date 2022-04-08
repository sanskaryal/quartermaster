import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quartermaster/services/models.dart';
import 'package:quartermaster/household/globals.dart';
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

  Future<ShoppingLists> getShopListInfo(shopListID) async {
    var ref = _db.collection('ShoppingLists').doc(shopListID);
    var snapshot = await ref.get();
    return ShoppingLists.fromJson(snapshot.data() ?? {});
  }

  Future<ShoppingItems> getShopItemsInfo(shopItemsID) async {
    var ref = _db.collection('ShoppingItems').doc(shopItemsID);
    var snapshot = await ref.get();
    return ShoppingItems.fromJson(snapshot.data() ?? {});
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

  Future<void> createShoppingLists(name, household, items) {
    var ref = _db.collection('ShoppingLists').doc();
    String shopListID = ref.id;

    var data = {
      'name': name,
      'household': household,
      'items': [],
    };
    addShopListtoHH(shopListID, Global.gethhid());
    // how to get houehold(choreIDseHoldID?
    // addChoreToHous, houseHoldID);

    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> ShoppingListItems(itemName, status, shopListID) {
    var ref = _db.collection('ShoppingItems').doc();
    String shopItemsID = ref.id;

    var data = {
      'itemName': itemName,
      'status': status,
      'shoppingListID': shopListID,
    };
    addShopItemstoList(shopItemsID, Global.getslid());
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> addShopListtoHH(shopListID, hhid) {
    var ref = _db.collection('Households').doc(hhid);

    var data = {
      'shoppingList': FieldValue.arrayUnion([shopListID])
    };

    // add a function to update the household field on users table
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> addShopItemstoList(shopItemsID, shopListID) {
    var ref = _db.collection('ShoppingLists').doc(shopListID);

    var data = {
      'items': FieldValue.arrayUnion([shopItemsID])
    };

    // add a function to update the household field on users table
    return ref.set(data, SetOptions(merge: true));
  }
}

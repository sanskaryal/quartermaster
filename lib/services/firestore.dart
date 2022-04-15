import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quartermaster/household/globals.dart';
import 'package:quartermaster/services/models.dart';
import 'package:quartermaster/household/globals.dart';
import 'auth.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var user = AuthService().user!;

  Future<void> createUsers(email, firstName, lastName) {
    var ref = _db.collection('Users').doc(user.uid);

    var data = {
      'uid': user.uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
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

  Future<void> createChores(name, member, frequency, date, hhid) {
    var ref = _db.collection('Chores').doc();
    String choreID = ref.id;

    var data = {
      'name': name,
      'member': member,
      'frequency': frequency,
      'dueDate': date
    };
    // how to get houseHoldID?
    addChoreToHouseHold(choreID, Global.gethhid());

    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> addChoreToHouseHold(cid, hhid) {
    var ref = _db.collection('Households').doc(hhid);

    var data = {
      'chores': FieldValue.arrayUnion([cid])
    };

    return ref.set(data, SetOptions(merge: true));
  }

  Future<Chores> getChoreInfo(choreID) async {
    var ref = _db.collection('Chores').doc(choreID);
    var snapshot = await ref.get();
    return Chores.fromJson(snapshot.data() ?? {});
  }

  Future<List<Users>> getHouseMembers(hid) async {
    List<Users> users = [];

    var ref = _db.collection('Users').where('houseHolds', arrayContains: hid);
    var snapshot = await ref.get();

    for (var user in snapshot.docs) {
      users.add(Users.fromJson(user.data()));
    }

    return users;
  }

  Future<List<String>> getHouseMemberIDs(hid) async {
    List<String> userIDs = [];
    var ref = _db.collection('Users').where('houseHolds', arrayContains: hid);
    var snapshot = await ref.get();

    for (var user in snapshot.docs) {
      userIDs.add(user.id);
    }

    return userIDs;
  }

  Future<List<String>> getHouseMemberNames(hid) async {
    List<String> memberNames = [];
    var ref = _db.collection('Users').where('houseHolds', arrayContains: hid);
    var snapshot = await ref.get();

    for (var user in snapshot.docs) {
      memberNames.add(user.get("firstName"));
    }

    return memberNames;
  }

  Future<String> getUidByEmail(email) async {
    var ref = _db.collection('Users').where("email", isEqualTo: email).limit(1);
    var snapshot = await ref.get();
    for (var user in snapshot.docs) {
      return user.id;
    }
    return "";
  }

  Future<void> addHidToUser(email, hhid) async {
    String uid = await getUidByEmail(email);
    var ref = _db.collection('Users').doc(uid);

    var data = {
      'houseHolds': FieldValue.arrayUnion([hhid])
    };
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> addUidtoHH(email, hhid) async {
    String uid = await getUidByEmail(email);
    var ref = _db.collection("Households").doc(hhid);

    var data = {
      'users': FieldValue.arrayUnion([uid])
    };
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> createExpense(String creatorID, String hhid, String name,
      String desc, double cost, List<String> members) {
    var ref = _db.collection('Expenses').doc();
    String expID = ref.id;

    var data = {
      'creatorID': creatorID,
      'hhid': hhid,
      'name': name,
      'description': desc,
      'cost': cost,
      'members': members,
    };

    addExpenseToHouseHold(expID, Global.gethhid());

    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> addExpenseToHouseHold(cid, hhid) {
    var ref = _db.collection('Households').doc(hhid);

    var data = {
      'expenses': FieldValue.arrayUnion([cid])
    };

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

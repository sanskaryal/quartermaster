import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Users {
  final String email;
  final String firstName;
  final String lastName;
  final List<String> houseHolds;

  Users(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.houseHolds = const []});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

@JsonSerializable()
class Households {
  final String name;
  final List<String> chores;
  final List<String> expenses;
  final List<String> shoppingList;
  final List<String> users;

  Households(
      {this.name = '',
      this.chores = const [],
      this.expenses = const [],
      this.shoppingList = const [],
      this.users = const []});

  factory Households.fromJson(Map<String, dynamic> json) =>
      _$HouseholdsFromJson(json);
  Map<String, dynamic> toJson() => _$HouseholdsToJson(this);
}

// chore model - NEEDS UPDATE
// model has changed since this was done.
// no longer using fields: status, type, startDate
// members now single String, no longer List<String>
@JsonSerializable()
class Chores {
  final String name;
  //final bool status;
  //final int type;
  //final List<String> members;
  final String member;
  final int frequency;
  //final String startDate;
  final String dueDate;

  Chores({
    this.name = '',
    //this.status = false,
    //this.type = 0,
    //this.members = const [],
    this.member = '',
    this.frequency = 0,
    //this.startDate = '',
    this.dueDate = '',
  });

  factory Chores.fromJson(Map<String, dynamic> json) => _$ChoresFromJson(json);
  Map<String, dynamic> toJson() => _$ChoresToJson(this);
}

@JsonSerializable()
class ShoppingLists {
  final String name;
  final String household;
  final List<String> items;

  ShoppingLists({this.name = '', this.household = '', this.items = const []});

  factory ShoppingLists.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListsFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingListsToJson(this);
}

@JsonSerializable()
class ShoppingItems {
  final String itemName;
  final bool status;
  final String shoppingListID;

  ShoppingItems(
      {this.itemName = '', this.status = false, this.shoppingListID = ''});

  factory ShoppingItems.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingItemsToJson(this);
}

class Expenses {
  final String creatorID;
  final String hhid;
  final String name;
  final String description;
  final double cost;
  final List<String> members;

  Expenses({
    this.creatorID = '',
    this.hhid = '',
    this.name = '',
    this.description = '',
    this.cost = 0.0,
    this.members = const [],
  });

  factory Expenses.fromJson(Map<String, dynamic> json) =>
      _$ExpensesFromJson(json);
  Map<String, dynamic> toJson() => _$ExpensesToJson(this);
}

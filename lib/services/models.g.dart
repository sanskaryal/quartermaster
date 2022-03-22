// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      houseHolds: (json['houseHolds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'houseHolds': instance.houseHolds,
    };

Households _$HouseholdsFromJson(Map<String, dynamic> json) => Households(
      name: json['name'] as String? ?? '',
      chores: (json['chores'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      expenses: (json['expenses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shoppingList: (json['shoppingList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$HouseholdsToJson(Households instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chores': instance.chores,
      'expenses': instance.expenses,
      'shoppingList': instance.shoppingList,
      'users': instance.users,
    };

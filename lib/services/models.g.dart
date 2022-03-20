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

HouseHold _$HouseHoldFromJson(Map<String, dynamic> json) => HouseHold(
      houseHoldName: json['houseHoldName'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HouseHoldToJson(HouseHold instance) => <String, dynamic>{
      'houseHoldName': instance.houseHoldName,
      'members': instance.members,
    };

Chores _$ChoresFromJson(Map<String, dynamic> json) => Chores(
      choreName: json['choreName'] as String? ?? '',
      freq: json['freq'] as int? ?? 0,
      houseHoldId: json['houseHoldId'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startingDate: json['startingDate'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$ChoresToJson(Chores instance) => <String, dynamic>{
      'choreName': instance.choreName,
      'freq': instance.freq,
      'houseHoldId': instance.houseHoldId,
      'members': instance.members,
      'startingDate': instance.startingDate,
      'type': instance.type,
    };

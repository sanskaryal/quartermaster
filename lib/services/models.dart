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
class HouseHold {
  final String houseHoldName;
  final List<String> members;

  HouseHold({this.houseHoldName = '', this.members = const []});

  factory HouseHold.fromJson(Map<String, dynamic> json) =>
      _$HouseHoldFromJson(json);
  Map<String, dynamic> toJson() => _$HouseHoldToJson(this);
}

@JsonSerializable()
class Chores {
  final String choreName;
  final int freq;
  final String houseHoldId;
  final List<String> members;
  final String startingDate;
  final String type;

  Chores(
      {this.choreName = '',
      this.freq = 0,
      this.houseHoldId = '',
      this.members = const [],
      this.startingDate = '',
      this.type = ''});

  factory Chores.fromJson(Map<String, dynamic> json) => _$ChoresFromJson(json);
  Map<String, dynamic> toJson() => _$ChoresToJson(this);
}

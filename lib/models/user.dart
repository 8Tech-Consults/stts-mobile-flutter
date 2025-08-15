import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String username;
  String email;
  String name;
  String avatar;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  String token;
  List<Role> roles;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.firstName,
    this.lastName,
    required this.avatar,
    required this.token,
    required this.roles,
  });
  Map toJson() {
    return _$UserToJson(this);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
}

@JsonSerializable()
class Role {
  int id;
  String name;
  String slug;

  Role({
    required this.id,
    required this.name,
    required this.slug,
  });
  Map toJson() {
    return _$RoleToJson(this);
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return _$RoleFromJson(json);
  }
}

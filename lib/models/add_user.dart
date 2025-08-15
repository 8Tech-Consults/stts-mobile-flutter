import 'package:json_annotation/json_annotation.dart';
part 'add_user.g.dart';

@JsonSerializable()
class AddUser {
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'first_name')
  String? firstName;
  String? email;
  String? password;
  String? name;

  AddUser({
    this.firstName,
    this.lastName,
    this.email,
    this.name,
    this.password,
  });
  Map toJson() {
    return _$AddUserToJson(this);
  }

  factory AddUser.fromJson(Map<String, dynamic> json) {
    return _$AddUserFromJson(json);
  }
}

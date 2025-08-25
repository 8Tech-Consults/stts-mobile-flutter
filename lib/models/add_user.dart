import 'package:json_annotation/json_annotation.dart';
part 'add_user.g.dart';

@JsonSerializable()
class AddUser {
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'first_name')
  String? firstName;
  String? email;
  @JsonKey(name: 'district')
  String? district;
  String? password;
  String? name;

  AddUser({
    this.firstName,
    this.lastName,
    this.email,
    this.district,
    this.name,
    this.password,
  });
  // Map toJson() {
  //   return _$AddUserToJson(this);
  // }
  Map<String, dynamic> toJson() {
    final json = _$AddUserToJson(this);

    // Combine firstName and lastName into "name"
    if (firstName != null || lastName != null) {
      json['name'] = "${firstName ?? ''} ${lastName ?? ''}".trim();
    }

    return json;
  }

  factory AddUser.fromJson(Map<String, dynamic> json) {
    return _$AddUserFromJson(json);
  }
}

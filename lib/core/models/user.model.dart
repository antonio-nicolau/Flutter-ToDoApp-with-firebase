import 'package:json_annotation/json_annotation.dart';
part 'user.model.g.dart';

@JsonSerializable()
class UserModel {
  final String? name;
  final String email;
  final String? id;
  final String password;

  UserModel({
    this.id,
    this.name,
    required this.email,
    required this.password,
  });

  UserModel copyWith({String? name, String? email, String? password, String? id}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

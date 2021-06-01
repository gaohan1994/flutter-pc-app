import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  String? token;
  String? avatar;
  String? merchantName;
  String? userName;
  int? cashierId;
  int? version;
  int? merchantId;

  UserModel({
    this.token,
    this.avatar,
    this.merchantName,
    this.userName,
    this.cashierId,
    this.version,
    this.merchantId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);
}

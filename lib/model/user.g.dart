// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    token: json['token'] as String?,
    avatar: json['avatar'] as String?,
    merchantName: json['merchantName'] as String?,
    userName: json['userName'] as String?,
    cashierId: json['cashierId'] as int?,
    version: json['version'] as int?,
    merchantId: json['merchantId'] as int?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'token': instance.token,
      'avatar': instance.avatar,
      'merchantName': instance.merchantName,
      'userName': instance.userName,
      'cashierId': instance.cashierId,
      'version': instance.version,
      'merchantId': instance.merchantId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) {
  return UserModel(
    json['token'] as String,
    json['avatar'] as String,
    json['merchantName'] as String,
    json['userName'] as String,
    json['cashierId'] as int,
    json['version'] as int,
    json['merchantId'] as int,
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberStatistic _$MemberStatisticFromJson(Map<String, dynamic> json) {
  return MemberStatistic(
    json['addMemberNum'] as int,
    json['totalMemberNum'] as int,
  );
}

Map<String, dynamic> _$MemberStatisticToJson(MemberStatistic instance) =>
    <String, dynamic>{
      'addMemberNum': instance.addMemberNum,
      'totalMemberNum': instance.totalMemberNum,
    };

MemberList _$MemberListFromJson(Map<String, dynamic> json) {
  return MemberList(
    (json['rows'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int,
  );
}

Map<String, dynamic> _$MemberListToJson(MemberList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows,
    };

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    json['avatar'] as String?,
    json['cardNo'] as String?,
    json['createTime'] as String?,
    json['lastPayTime'] as String?,
    json['levelName'] as String?,
    json['phone'] as String,
    json['username'] as String,
    json['id'] as int,
    (json['totalAmount'] as num).toDouble(),
    (json['totalTimes'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'cardNo': instance.cardNo,
      'createTime': instance.createTime,
      'lastPayTime': instance.lastPayTime,
      'levelName': instance.levelName,
      'phone': instance.phone,
      'username': instance.username,
      'id': instance.id,
      'totalAmount': instance.totalAmount,
      'totalTimes': instance.totalTimes,
    };

MemberDetail _$MemberDetailFromJson(Map<String, dynamic> json) {
  return MemberDetail()
    ..avatar = json['avatar'] as String?
    ..cardNo = json['cardNo'] as String?
    ..createTime = json['createTime'] as String?
    ..lastPayTime = json['lastPayTime'] as String?
    ..levelName = json['levelName'] as String?
    ..phone = json['phone'] as String
    ..username = json['username'] as String
    ..id = json['id'] as int
    ..totalAmount = (json['totalAmount'] as num).toDouble()
    ..totalTimes = (json['totalTimes'] as num?)?.toDouble()
    ..sex = json['sex'] as String?
    ..birthDate = json['birthDate'] as String?
    ..merchantName = json['merchantName'] as String
    ..enableMemberPrice = json['enableMemberPrice'] as bool?
    ..status = json['status'] as int?
    ..merchantId = (json['merchantId'] as num?)?.toDouble()
    ..points = (json['points'] as num?)?.toDouble()
    ..overage = (json['overage'] as num?)?.toDouble()
    ..accumulativePoints = (json['accumulativePoints'] as num?)?.toDouble()
    ..accumulativeMoney = (json['accumulativeMoney'] as num?)?.toDouble()
    ..memberDiscount = (json['memberDiscount'] as num?)?.toDouble()
    ..obtainMoney = (json['obtainMoney'] as num?)?.toDouble()
    ..obtainPoints = (json['obtainPoints'] as num?)?.toDouble()
    ..preferenceVo = (json['preferenceVo'] as List<dynamic>?)
        ?.map((e) => Preference.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MemberDetailToJson(MemberDetail instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'cardNo': instance.cardNo,
      'createTime': instance.createTime,
      'lastPayTime': instance.lastPayTime,
      'levelName': instance.levelName,
      'phone': instance.phone,
      'username': instance.username,
      'id': instance.id,
      'totalAmount': instance.totalAmount,
      'totalTimes': instance.totalTimes,
      'sex': instance.sex,
      'birthDate': instance.birthDate,
      'merchantName': instance.merchantName,
      'enableMemberPrice': instance.enableMemberPrice,
      'status': instance.status,
      'merchantId': instance.merchantId,
      'points': instance.points,
      'overage': instance.overage,
      'accumulativePoints': instance.accumulativePoints,
      'accumulativeMoney': instance.accumulativeMoney,
      'memberDiscount': instance.memberDiscount,
      'obtainMoney': instance.obtainMoney,
      'obtainPoints': instance.obtainPoints,
      'preferenceVo': instance.preferenceVo,
    };

Preference _$PreferenceFromJson(Map<String, dynamic> json) {
  return Preference(
    json['purchaseNum'] as int,
    json['purchaseTotalNum'] as int,
    json['typeId'] as String,
    json['typeName'] as String,
  );
}

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'purchaseNum': instance.purchaseNum,
      'purchaseTotalNum': instance.purchaseTotalNum,
      'typeId': instance.typeId,
      'typeName': instance.typeName,
    };

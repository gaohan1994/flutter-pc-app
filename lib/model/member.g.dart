// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberStatistic _$MemberStatisticFromJson(Map json) {
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

MemberList _$MemberListFromJson(Map json) {
  return MemberList(
    (json['rows'] as List<dynamic>)
        .map((e) => Member.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    json['total'] as int,
  );
}

Map<String, dynamic> _$MemberListToJson(MemberList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };

Member _$MemberFromJson(Map json) {
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

Map<String, dynamic> _$MemberToJson(Member instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar);
  writeNotNull('cardNo', instance.cardNo);
  writeNotNull('createTime', instance.createTime);
  writeNotNull('lastPayTime', instance.lastPayTime);
  writeNotNull('levelName', instance.levelName);
  val['phone'] = instance.phone;
  val['username'] = instance.username;
  val['id'] = instance.id;
  val['totalAmount'] = instance.totalAmount;
  writeNotNull('totalTimes', instance.totalTimes);
  return val;
}

MemberDetail _$MemberDetailFromJson(Map json) {
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
    ..preferenceVo = json['preferenceVo'] as List<dynamic>?;
}

Map<String, dynamic> _$MemberDetailToJson(MemberDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar);
  writeNotNull('cardNo', instance.cardNo);
  writeNotNull('createTime', instance.createTime);
  writeNotNull('lastPayTime', instance.lastPayTime);
  writeNotNull('levelName', instance.levelName);
  val['phone'] = instance.phone;
  val['username'] = instance.username;
  val['id'] = instance.id;
  val['totalAmount'] = instance.totalAmount;
  writeNotNull('totalTimes', instance.totalTimes);
  writeNotNull('sex', instance.sex);
  writeNotNull('birthDate', instance.birthDate);
  val['merchantName'] = instance.merchantName;
  writeNotNull('enableMemberPrice', instance.enableMemberPrice);
  writeNotNull('status', instance.status);
  writeNotNull('merchantId', instance.merchantId);
  writeNotNull('points', instance.points);
  writeNotNull('overage', instance.overage);
  writeNotNull('accumulativePoints', instance.accumulativePoints);
  writeNotNull('accumulativeMoney', instance.accumulativeMoney);
  writeNotNull('memberDiscount', instance.memberDiscount);
  writeNotNull('obtainMoney', instance.obtainMoney);
  writeNotNull('obtainPoints', instance.obtainPoints);
  writeNotNull('preferenceVo', instance.preferenceVo);
  return val;
}

Preference _$PreferenceFromJson(Map json) {
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

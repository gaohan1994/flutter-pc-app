import 'package:json_annotation/json_annotation.dart';
part 'member.g.dart';

@JsonSerializable()
class MemberStatistic {
  MemberStatistic(
    this.addMemberNum,
    this.totalMemberNum,
  );

  // 今日新增会员数
  int addMemberNum;
  // 总会员数
  int totalMemberNum;

  factory MemberStatistic.fromJson(Map<String, dynamic> json) =>
      _$MemberStatisticFromJson(json);

  toJson() => _$MemberStatisticToJson(this);
}

@JsonSerializable()
class MemberList {
  MemberList(this.rows, this.total);

  int total;

  List<Member> rows;

  factory MemberList.fromJson(Map<String, dynamic> json) =>
      _$MemberListFromJson(json);

  toJson() => _$MemberListToJson(this);
}

@JsonSerializable()
class Member {
  Member(
    this.avatar,
    this.cardNo,
    this.createTime,
    this.lastPayTime,
    this.levelName,
    this.phone,
    this.username,
    this.id,
    this.totalAmount,
    this.totalTimes,
  );

  String? avatar;
  String? cardNo;
  String? createTime;
  String? lastPayTime;
  String? levelName;
  String phone;
  String username;
  int id;
  double totalAmount;
  double? totalTimes;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class MemberDetail {
  MemberDetail();

  String? avatar = '';
  String? cardNo = '';
  String? createTime = '';
  String? lastPayTime = '';
  String? levelName = '';
  String phone = '';
  String username = '';
  int id = 0;
  double totalAmount = 0;
  double? totalTimes = 0;
  String? sex = '0';
  String? birthDate = '';

  String merchantName = '';
  bool? enableMemberPrice = false;
  int? status = 0;
  double? merchantId = 0;
  double? points = 0;
  double? overage = 0;
  double? accumulativePoints = 0;
  double? accumulativeMoney = 0;
  double? memberDiscount = 0;
  double? obtainMoney = 0;
  double? obtainPoints = 0;
  List<dynamic>? preferenceVo = [];

  factory MemberDetail.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailFromJson(json);

  toJson() => _$MemberDetailToJson(this);
}

@JsonSerializable()
class Preference {
  int purchaseNum;
  int purchaseTotalNum;
  String typeId;
  String typeName;
  Preference(
    this.purchaseNum,
    this.purchaseTotalNum,
    this.typeId,
    this.typeName,
  );

  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);

  toJson() => _$PreferenceToJson(this);
}

@JsonSerializable()
class MemberInfoAdd {
  MemberInfoAdd({
    required this.cardNo,
    required this.phone,
    required this.status,
    required this.username,
    this.avatar,
    this.birthDate,
    this.id,
    this.levelId,
    this.sex,
  });

  String cardNo;
  String phone;
  int status;
  String username;
  String? avatar;
  String? birthDate;
  int? id;
  int? levelId;
  int? sex;

  factory MemberInfoAdd.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoAddFromJson(json);

  toJson() => _$MemberInfoAddToJson(this);
}

@JsonSerializable()
class MemberLevel {
  MemberLevel(
    this.accumulativePointsThreshold,
    this.enableMemberPrice,
    this.levelName,
    this.id,
    this.level,
    this.merchantId,
    this.obtainPoints,
    this.status,
    this.storeThreshold,
    this.memberDiscount,
    this.obtainMoney,
  );

  double accumulativePointsThreshold;
  bool enableMemberPrice;
  String levelName;
  int id;
  int level;
  int merchantId;
  double obtainPoints;
  bool status;
  double? storeThreshold;
  double? memberDiscount;
  double? obtainMoney;
  factory MemberLevel.fromJson(Map<String, dynamic> json) =>
      _$MemberLevelFromJson(json);

  toJson() => _$MemberLevelToJson(this);
}

@JsonSerializable()
class MemberLevelInterface {
  MemberLevelInterface(
    this.total,
    this.rows,
  );

  // 今日新增会员数
  int total;
  // 总会员数
  List<MemberLevel> rows;

  factory MemberLevelInterface.fromJson(Map<String, dynamic> json) =>
      _$MemberLevelInterfaceFromJson(json);

  toJson() => _$MemberLevelInterfaceToJson(this);
}

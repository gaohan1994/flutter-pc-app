// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportToday _$ReportTodayFromJson(Map json) {
  return ReportToday(
    json['todayAddMember'] as int,
    json['todaySaleTimes'] as int,
    (json['todaySales'] as num).toDouble(),
    json['totalMember'] as int,
  );
}

Map<String, dynamic> _$ReportTodayToJson(ReportToday instance) =>
    <String, dynamic>{
      'todayAddMember': instance.todayAddMember,
      'todaySaleTimes': instance.todaySaleTimes,
      'todaySales': instance.todaySales,
      'totalMember': instance.totalMember,
    };

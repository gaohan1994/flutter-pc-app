import 'package:json_annotation/json_annotation.dart';
part 'report.g.dart';

@JsonSerializable()
class ReportToday {
  ReportToday(
    this.todayAddMember,
    this.todaySaleTimes,
    this.todaySales,
    this.totalMember,
  );

  int todayAddMember;
  int todaySaleTimes;
  double todaySales;
  int totalMember;

  factory ReportToday.fromJson(Map<String, dynamic> json) =>
      _$ReportTodayFromJson(json);

  toJson() => _$ReportTodayToJson(this);
}

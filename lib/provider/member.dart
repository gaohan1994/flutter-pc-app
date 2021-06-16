import 'package:flutter/material.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/service/member_method.dart';
import 'dart:convert';

class MemberProvider extends ChangeNotifier {
  // 页数
  int page = 1;
  // 页码
  int pageSize = 20;
  // 订单数
  int total = 0;

  int selectedId = 0;
  // 搜索的值
  String searchValue = '';

  // 排序方式
  String filterWay = 'totalAmount';
  void setFilterWay(way) {
    filterWay = way;
    getMemberList();
    notifyListeners();
  }

  // 排序规则
  String filterBy = 'desc';
  void setFilterBy(by) {
    filterBy = by;
    getMemberList();
    notifyListeners();
  }

  // 列表
  List<Member> memberList = [];

  MemberStatistic memberStatic = MemberStatistic(0, 0);

  MemberDetail memberDetail = MemberDetail();

  // 获取会员统计
  Future getMemberStatic() async {
    var result = await fetchMemberInfoStatic();
    var resultMap = json.decode(result.toString());
    var resultData = MemberStatistic.fromJson(resultMap['data']);

    memberStatic = resultData;
    notifyListeners();
  }

  Future getMemberList() async {
    var params = {
      "pageNum": 1,
      "pageSize": "${pageSize}",
      // "orderByColumn": "${filterWay} ${filterBy}"
    };

    if (searchValue.isNotEmpty) {
      params['identity'] = searchValue;
    }

    print('getMemberList 请求列表参数: ${params.toString()}');

    var result = await fetchMemberList(params: params);
    var resultMap = json.decode(result.toString());

    var listData = MemberList.fromJson(resultMap['data']);
    var listTotal = listData.total;
    var listRows = listData.rows;

    if (listRows.isNotEmpty) {
      getMemberDetail(listRows[0].id);
    }

    total = listTotal;
    memberList = listRows;

    notifyListeners();
  }

  // 获取详情
  Future getMemberDetail(int id) async {
    var result = await fetchMemberDetail(id: id);
    var resultMap = json.decode(result.toString());
    var data = MemberDetail.fromJson(resultMap['data']);

    memberDetail = data;
    notifyListeners();
  }

  void changeSelectedMember(Member item) {
    selectedId = item.id;
    getMemberDetail(item.id);
    notifyListeners();
  }
}

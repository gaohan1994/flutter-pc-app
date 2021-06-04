import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/model/report.dart';
import 'package:pc_app/model/user.dart';
import 'package:pc_app/service/report_method.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReportProvider extends ChangeNotifier {
  ReportToday? reportTokey;

  Future getReportToday() async {
    // SharedPreferences sp = await SharedPreferences.getInstance();

    // var userString = sp.getString('user');

    // // 首先拿到用户数据
    // if (userString != null && userString.isNotEmpty) {
    //   print('userString: ${userString}');
    //   UserModel user = UserModel.fromJson(json.decode(userString));
    //   var params = {"merchantId": user.merchantId};
    //   print('请求今日报表参数：${params.toString()}');

    //   var result = await fetchReportToday(params: params);
    //   var resultMap = json.decode(result.toString());

    //   var todayData = ReportToday.fromJson(resultMap['data']);

    //   reportTokey = todayData;
    //   notifyListeners();
    // } else {
    //   showToast('请先登录');
    // }
  }
}

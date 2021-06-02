import 'package:flutter/material.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/service/order_method.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class OrderPageProvider extends ChangeNotifier {
  DateFormat format = DateFormat('yyyy-MM-dd');

  // 页数
  int page = 1;
  // 页码
  int pageSize = 20;

  // 订单列表
  List<Order> _orderList = [];
  List<Order> get orderList => _orderList;

  // 订单列表按照时间排序
  List<OrderByTime> _orderListByTime = [];
  List<OrderByTime> get orderListByTime => _orderListByTime;

  void setOrderListByTime(List<Order> data) {
    List<OrderByTime> _dataByTime = _orderListByTime;

    for (int i = 0; i < data.length; i++) {
      var currentOrder = data[i];
      var currentOrderTime =
          format.format(DateTime.parse(currentOrder.createTime)).toString();

      // 查找按照时间排序的数组里面有没有当前order时间得项
      int byTimeIndex = _dataByTime.indexWhere((dataItemByTime) {
        return dataItemByTime.title == currentOrderTime;
      });

      // 如果查到有这个时间戳的数组了则插入到找到的这个数组中，如果没有则新建
      if (byTimeIndex == -1) {
        OrderByTime obt = OrderByTime(currentOrderTime, [currentOrder]);
        _dataByTime.add(obt);
      } else {
        _dataByTime[byTimeIndex].data.add(currentOrder);
      }
    }

    _orderListByTime = _dataByTime;
    notifyListeners();
  }

  // 请求列表，过程很繁琐 用心感受
  Future<void> getOrderList() async {
    var params = {
      "pageNum": 1,
      "pageSize": pageSize,
      "orderByColumn": "o.create_time desc"
    };
    print('getOrderList 请求订单列表参数: ${params.toString()}');

    var result = await fetchOrderList(params: params);
    var resultMap = json.decode(result.toString());

    var orderListRows = OrderList.fromJson(resultMap['data']).rows;

    _orderList = orderListRows;
    setOrderListByTime(_orderList);

    page = 1;
    notifyListeners();
  }

  // 请求列表，过程很繁琐 用心感受
  Future<void> loadMoreOrder() async {
    var params = {
      "pageNum": page + 1,
      "pageSize": pageSize,
      "orderByColumn": "o.create_time desc"
    };
    print('loadMoreOrder 请求订单列表参数: ${params.toString()}');

    var result = await fetchOrderList(params: params);
    var resultMap = json.decode(result.toString());

    var newList = OrderList.fromJson(resultMap['data']).rows;

    _orderList.addAll(newList);
    setOrderListByTime(_orderList);

    page++;
    notifyListeners();
  }
}

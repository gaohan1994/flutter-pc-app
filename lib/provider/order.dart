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
  // 订单数
  int total = 0;
  // 搜索的值
  String searchValue = '';
  // 起始日期
  String startTime = '';
  // 结束日期
  String endTime = '';

  // 订单列表
  List<Order> _orderList = [];
  List<Order> get orderList => _orderList;
  set orderList(List<Order> list) {
    _orderList = list;
    setOrderListByTime(list);
  }

  // 订单列表按照时间排序
  List<OrderByTime> _orderListByTime = [];
  List<OrderByTime> get orderListByTime => _orderListByTime;

  // 选中的订单id
  String _selectedOrderId = '';
  String get selectedOrderId => _selectedOrderId;

  OrderDetail? orderDetail;

  void setOrderListByTime(List<Order> data) {
    if (data.isEmpty) {
      _orderListByTime = [];
    } else {
      List<OrderByTime> _dataByTime = [];

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
    }

    notifyListeners();
  }

  // 请求列表，过程很繁琐 用心感受
  Future<void> getOrderList() async {
    var params = {
      "pageNum": 1,
      "pageSize": pageSize,
      "transFlag": 2,
      "orderByColumn": "o.create_time desc"
    };

    // 如果搜索的不是空值则查询
    if (searchValue.isNotEmpty) {
      params['orderNo'] = searchValue;
    }

    if (startTime.isNotEmpty) {
      params['startTime'] = startTime;
    }

    if (endTime.isNotEmpty) {
      params['endTime'] = endTime;
    }

    print('getOrderList 请求订单列表参数: ${params.toString()}');

    var result = await fetchOrderList(params: params);
    var resultMap = json.decode(result.toString());

    var orderListData = OrderList.fromJson(resultMap['data']);
    var orderListTotal = orderListData.total;
    var orderListRows = orderListData.rows;

    total = orderListTotal;

    _orderList = orderListRows;
    setOrderListByTime(_orderList);

    if (orderListRows.isNotEmpty) {
      getOrderDetail(orderListRows[0].orderNo);
    }

    page = 1;
    notifyListeners();
  }

  // 请求列表，过程很繁琐 用心感受
  Future<void> loadMoreOrder() async {
    var params = {
      "pageNum": page + 1,
      "pageSize": pageSize,
      "transFlag": 2,
      "orderByColumn": "o.create_time desc"
    };

    // 如果搜索的不是空值则查询
    if (searchValue.isNotEmpty) {
      params['orderNo'] = searchValue;
    }

    if (startTime.isNotEmpty) {
      params['startTime'] = startTime;
    }

    if (endTime.isNotEmpty) {
      params['endTime'] = endTime;
    }

    print('loadMoreOrder 请求订单列表参数: ${params.toString()}');

    var result = await fetchOrderList(params: params);
    var resultMap = json.decode(result.toString());

    var newList = OrderList.fromJson(resultMap['data']).rows;

    _orderList.addAll(newList);
    setOrderListByTime(_orderList);

    page++;
    notifyListeners();
  }

  // 点击订单时触发修改选中id和详情
  void changeSelectedOrder(Order item) {
    _selectedOrderId = item.orderNo;
    getOrderDetail(item.orderNo);
    notifyListeners();
  }

  // 请求订单详情
  Future getOrderDetail(String orderId) async {
    var params = {"orderNo": orderId};
    print('请求订单详情参数:${params}');

    var result = await fetchOrderDetail(params: params);
    var resultMap = json.decode(result.toString());
    var _detail = OrderDetail.fromJson(resultMap['data']);

    orderDetail = _detail;
    notifyListeners();
  }

  static String getOrderStatus(status) {
    switch (status) {
      case -2:
        return '异常订单';
      case -1:
        return '交易失败';
      case 0:
        return '待支付';
      case 1:
        return '支付完成';
      case 2:
        return '交易关闭';
      case 3:
        return '交易完成';
      case 4:
        return '交易取消';
      case 5:
        return '支付中';
      default:
        return '';
    }
  }

  static String getOrderRefundStatus(status) {
    switch (status) {
      case 0:
        return '未退货';
      case 1:
        return '全部退货';
      case 2:
        return '部分退货';
      default:
        return '';
    }
  }
}

import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class OrderList {
  OrderList(this.rows, this.total);

  int total;

  List<Order> rows;

  factory OrderList.fromJson(Map<String, dynamic> json) =>
      _$OrderListFromJson(json);

  toJson() => _$OrderListToJson(this);
}

@JsonSerializable()
class Order {
  Order(
    this.orderNo,
    this.amt,
    this.transFlag,
    this.refundStatus,
    this.createTime,
  );

  String orderNo;
  double amt;
  int transFlag;
  int refundStatus;
  String createTime;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  toJson() => _$OrderToJson(this);
}

class OrderByTime {
  OrderByTime(this.title, this.data);
  String title;
  List<Order> data;
}

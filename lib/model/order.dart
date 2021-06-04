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

  // 0 未退货 1 全部退货 2 部分退货
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

@JsonSerializable()
class OrderDetail {
  OrderDetail(
    this.orderNo,
    this.amt,
    this.transFlag,
    this.totalNum,
    this.originalAmt,
    this.productDiscount,
    this.fullDiscount,
    this.couponDiscount,
    this.priceDiscount,
    this.eraseDiscount,
    this.pointDiscount,
    this.cashierName,
    this.createTime,
    this.productList,
  );

  String orderNo;
  double amt;
  double transFlag;
  double totalNum;
  double originalAmt;
  double productDiscount;
  double fullDiscount;
  double couponDiscount;
  double priceDiscount;
  double eraseDiscount;
  double pointDiscount;
  String cashierName;
  String createTime;

  List<OrderProductListItem> productList;

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  toJson() => _$OrderDetailToJson(this);
}

@JsonSerializable()
class OrderProductListItem {
  OrderProductListItem(
    this.productName,
    this.canRefund,
    this.orderDetailId,
    this.productId,
    this.originUnitPrice,
    this.sendUnitPrice,
    this.num,
    this.amt,
    this.totalAmount,
  );

  String productName;
  bool canRefund;
  double orderDetailId;
  double productId;
  double originUnitPrice;
  double sendUnitPrice;
  double num;
  double amt;
  double totalAmount;

  factory OrderProductListItem.fromJson(Map<String, dynamic> json) =>
      _$OrderProductListItemFromJson(json);

  toJson() => _$OrderProductListItemToJson(this);
}

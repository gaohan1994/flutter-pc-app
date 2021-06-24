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

@JsonSerializable()
class CashierOrder {
  CashierOrder(this.flag, this.order, this.productInfoList);
  bool flag;
  CashierOrderInfo order;
  List<CashierOrderProductInfo> productInfoList;

  factory CashierOrder.fromJson(Map<String, dynamic> json) =>
      _$CashierOrderFromJson(json);

  toJson() => _$CashierOrderToJson(this);
}

@JsonSerializable()
class CashierOrderInfo {
  CashierOrderInfo({
    required this.amt,
    required this.orderSource,
    required this.payType,
    required this.totalNum,
    this.couponDiscount,
    this.eraseDiscount,
    this.fullDiscount,
    this.memberId,
    this.merchantId,
    this.originalAmt,
    this.pointDiscount,
    this.points,
    this.priceDiscount,
    this.productDiscount,
    this.couponList,
    this.remark,
    this.terminalSn,
  });

  double amt;
  int orderSource;
  int payType;
  double totalNum;
  double? couponDiscount;
  double? eraseDiscount;
  double? fullDiscount;
  int? memberId;
  int? merchantId;
  double? originalAmt;
  double? pointDiscount;
  int? points;
  double? priceDiscount;
  double? productDiscount;
  List? couponList;
  String? remark;
  String? terminalSn;

  factory CashierOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$CashierOrderInfoFromJson(json);

  toJson() => _$CashierOrderInfoToJson(this);
}

@JsonSerializable()
class CashierOrderProductInfo {
  CashierOrderProductInfo({
    required this.sellNum,
    this.pointDiscount,
    this.priceChangeFlag,
    this.productId,
    this.productName,
    this.remark,
    this.unitPrice,
  });

  double sellNum;
  double? pointDiscount;
  bool? priceChangeFlag;
  int? productId;
  String? productName;
  String? remark;
  double? unitPrice;

  factory CashierOrderProductInfo.fromJson(Map<String, dynamic> json) =>
      _$CashierOrderProductInfoFromJson(json);

  toJson() => _$CashierOrderProductInfoToJson(this);
}

@JsonSerializable()
class CashierConfirm {
  CashierConfirm({
    required this.orderNo,
    required this.payType,
    required this.thirdPartFlag,
    required this.transFlag,
    this.isCombined,
    this.transaction,
  });
  String orderNo;
  int payType;
  int thirdPartFlag;
  int transFlag;
  bool? isCombined;
  CashierConfirmTransaction? transaction;

  factory CashierConfirm.fromJson(Map<String, dynamic> json) =>
      _$CashierConfirmFromJson(json);

  toJson() => _$CashierConfirmToJson(this);
}

@JsonSerializable()
class CashierConfirmTransaction {
  CashierConfirmTransaction({
    required this.amt,
    required this.orderNo,
    required this.originAmount,
    required this.payType,
    required this.terminalSn,
    required this.transactionStatus,
    required this.transNo,
    this.authCode,
    this.oldAmount,
    this.batchNo,
    this.cardNo,
    this.cardinPutMethod,
    this.merchantName,
    this.merchantOrderNo,
    this.operatorId,
    this.refNo,
    this.remark,
    this.scanOrderId,
    this.traceNo,
    this.transDate,
    this.transTime,
    this.transType,
    this.unionNo,
  });

  double amt;
  String orderNo;
  double originAmount;
  int payType;
  String terminalSn;
  int transactionStatus;
  String transNo;
  String? authCode;
  double? oldAmount;
  String? batchNo;
  String? cardNo;
  String? cardinPutMethod;
  String? merchantName;
  String? merchantOrderNo;
  String? operatorId;
  String? refNo;
  String? remark;
  String? scanOrderId;
  String? traceNo;
  String? transDate;
  String? transTime;
  String? transType;
  String? unionNo;

  factory CashierConfirmTransaction.fromJson(Map<String, dynamic> json) =>
      _$CashierConfirmTransactionFromJson(json);

  toJson() => _$CashierConfirmTransactionToJson(this);
}

@JsonSerializable()
class CashierRefund {
  CashierRefund(this.order, this.productInfoList);

  CashierRefundOrder order;
  List<CashierRefundProduct> productInfoList;

  factory CashierRefund.fromJson(Map<String, dynamic> json) =>
      _$CashierRefundFromJson(json);

  toJson() => _$CashierRefundToJson(this);
}

@JsonSerializable()
class CashierRefundOrder {
  CashierRefundOrder({
    required this.amt,
    required this.orderSource,
    this.cashierId,
    this.terminalSn,
    this.thirdPartFlag,
    this.remark,
  });
  double amt;
  int orderSource;
  int? cashierId;
  String? terminalSn;
  int? thirdPartFlag;
  String? remark;

  factory CashierRefundOrder.fromJson(Map<String, dynamic> json) =>
      _$CashierRefundOrderFromJson(json);

  toJson() => _$CashierRefundOrderToJson(this);
}

@JsonSerializable()
class CashierRefundProduct {
  CashierRefundProduct({
    required this.changeNumber,
    required this.unitPrice,
    required this.productId,
    required this.productName,
    this.remark,
  });

  double changeNumber;
  double unitPrice;
  int productId;
  String productName;
  String? remark;

  factory CashierRefundProduct.fromJson(Map<String, dynamic> json) =>
      _$CashierRefundProductFromJson(json);

  toJson() => _$CashierRefundProductToJson(this);
}

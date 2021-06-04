// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderList _$OrderListFromJson(Map<String, dynamic> json) {
  return OrderList(
    (json['rows'] as List<dynamic>)
        .map((e) => Order.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int,
  );
}

Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['orderNo'] as String,
    (json['amt'] as num).toDouble(),
    json['transFlag'] as int,
    json['refundStatus'] as int,
    json['createTime'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderNo': instance.orderNo,
      'amt': instance.amt,
      'transFlag': instance.transFlag,
      'refundStatus': instance.refundStatus,
      'createTime': instance.createTime,
    };

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
    json['orderNo'] as String,
    (json['amt'] as num).toDouble(),
    (json['transFlag'] as num).toDouble(),
    (json['totalNum'] as num).toDouble(),
    (json['originalAmt'] as num).toDouble(),
    (json['productDiscount'] as num).toDouble(),
    (json['fullDiscount'] as num).toDouble(),
    (json['couponDiscount'] as num).toDouble(),
    (json['priceDiscount'] as num).toDouble(),
    (json['eraseDiscount'] as num).toDouble(),
    (json['pointDiscount'] as num).toDouble(),
    json['cashierName'] as String,
    json['createTime'] as String,
    (json['productList'] as List<dynamic>)
        .map((e) => OrderProductListItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'amt': instance.amt,
      'transFlag': instance.transFlag,
      'totalNum': instance.totalNum,
      'originalAmt': instance.originalAmt,
      'productDiscount': instance.productDiscount,
      'fullDiscount': instance.fullDiscount,
      'couponDiscount': instance.couponDiscount,
      'priceDiscount': instance.priceDiscount,
      'eraseDiscount': instance.eraseDiscount,
      'pointDiscount': instance.pointDiscount,
      'cashierName': instance.cashierName,
      'createTime': instance.createTime,
      'productList': instance.productList,
    };

OrderProductListItem _$OrderProductListItemFromJson(Map<String, dynamic> json) {
  return OrderProductListItem(
    json['productName'] as String,
    json['canRefund'] as bool,
    (json['orderDetailId'] as num).toDouble(),
    (json['productId'] as num).toDouble(),
    (json['originUnitPrice'] as num).toDouble(),
    (json['sendUnitPrice'] as num).toDouble(),
    (json['num'] as num).toDouble(),
    (json['amt'] as num).toDouble(),
    (json['totalAmount'] as num).toDouble(),
  );
}

Map<String, dynamic> _$OrderProductListItemToJson(
        OrderProductListItem instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'canRefund': instance.canRefund,
      'orderDetailId': instance.orderDetailId,
      'productId': instance.productId,
      'originUnitPrice': instance.originUnitPrice,
      'sendUnitPrice': instance.sendUnitPrice,
      'num': instance.num,
      'amt': instance.amt,
      'totalAmount': instance.totalAmount,
    };

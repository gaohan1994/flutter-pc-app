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

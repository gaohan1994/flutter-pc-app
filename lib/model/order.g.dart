// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderList _$OrderListFromJson(Map json) {
  return OrderList(
    (json['rows'] as List<dynamic>)
        .map((e) => Order.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    json['total'] as int,
  );
}

Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };

Order _$OrderFromJson(Map json) {
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

OrderDetail _$OrderDetailFromJson(Map json) {
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
        .map((e) =>
            OrderProductListItem.fromJson(Map<String, dynamic>.from(e as Map)))
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
      'productList': instance.productList.map((e) => e.toJson()).toList(),
    };

OrderProductListItem _$OrderProductListItemFromJson(Map json) {
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

CashierOrder _$CashierOrderFromJson(Map json) {
  return CashierOrder(
    json['flag'] as bool,
    CashierOrderInfo.fromJson(Map<String, dynamic>.from(json['order'] as Map)),
    (json['productInfoList'] as List<dynamic>)
        .map((e) => CashierOrderProductInfo.fromJson(
            Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$CashierOrderToJson(CashierOrder instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'order': instance.order.toJson(),
      'productInfoList':
          instance.productInfoList.map((e) => e.toJson()).toList(),
    };

CashierOrderInfo _$CashierOrderInfoFromJson(Map json) {
  return CashierOrderInfo(
    amt: (json['amt'] as num).toDouble(),
    orderSource: json['orderSource'] as int,
    payType: json['payType'] as int,
    totalNum: (json['totalNum'] as num).toDouble(),
    couponDiscount: (json['couponDiscount'] as num?)?.toDouble(),
    eraseDiscount: (json['eraseDiscount'] as num?)?.toDouble(),
    fullDiscount: (json['fullDiscount'] as num?)?.toDouble(),
    memberId: json['memberId'] as int?,
    merchantId: json['merchantId'] as int?,
    originalAmt: (json['originalAmt'] as num?)?.toDouble(),
    pointDiscount: (json['pointDiscount'] as num?)?.toDouble(),
    points: json['points'] as int?,
    priceDiscount: (json['priceDiscount'] as num?)?.toDouble(),
    productDiscount: (json['productDiscount'] as num?)?.toDouble(),
    couponList: json['couponList'] as List<dynamic>?,
    remark: json['remark'] as String?,
    terminalSn: json['terminalSn'] as String?,
  );
}

Map<String, dynamic> _$CashierOrderInfoToJson(CashierOrderInfo instance) {
  final val = <String, dynamic>{
    'amt': instance.amt,
    'orderSource': instance.orderSource,
    'payType': instance.payType,
    'totalNum': instance.totalNum,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('couponDiscount', instance.couponDiscount);
  writeNotNull('eraseDiscount', instance.eraseDiscount);
  writeNotNull('fullDiscount', instance.fullDiscount);
  writeNotNull('memberId', instance.memberId);
  writeNotNull('merchantId', instance.merchantId);
  writeNotNull('originalAmt', instance.originalAmt);
  writeNotNull('pointDiscount', instance.pointDiscount);
  writeNotNull('points', instance.points);
  writeNotNull('priceDiscount', instance.priceDiscount);
  writeNotNull('productDiscount', instance.productDiscount);
  writeNotNull('couponList', instance.couponList);
  writeNotNull('remark', instance.remark);
  writeNotNull('terminalSn', instance.terminalSn);
  return val;
}

CashierOrderProductInfo _$CashierOrderProductInfoFromJson(Map json) {
  return CashierOrderProductInfo(
    sellNum: (json['sellNum'] as num).toDouble(),
    pointDiscount: (json['pointDiscount'] as num?)?.toDouble(),
    priceChangeFlag: json['priceChangeFlag'] as bool?,
    productId: json['productId'] as int?,
    productName: json['productName'] as String?,
    remark: json['remark'] as String?,
    unitPrice: (json['unitPrice'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$CashierOrderProductInfoToJson(
    CashierOrderProductInfo instance) {
  final val = <String, dynamic>{
    'sellNum': instance.sellNum,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pointDiscount', instance.pointDiscount);
  writeNotNull('priceChangeFlag', instance.priceChangeFlag);
  writeNotNull('productId', instance.productId);
  writeNotNull('productName', instance.productName);
  writeNotNull('remark', instance.remark);
  writeNotNull('unitPrice', instance.unitPrice);
  return val;
}

CashierConfirm _$CashierConfirmFromJson(Map json) {
  return CashierConfirm(
    orderNo: json['orderNo'] as String,
    payType: json['payType'] as int,
    thirdPartFlag: json['thirdPartFlag'] as int,
    transFlag: json['transFlag'] as int,
    isCombined: json['isCombined'] as bool?,
    transaction: json['transaction'] == null
        ? null
        : CashierConfirmTransaction.fromJson(
            Map<String, dynamic>.from(json['transaction'] as Map)),
  );
}

Map<String, dynamic> _$CashierConfirmToJson(CashierConfirm instance) {
  final val = <String, dynamic>{
    'orderNo': instance.orderNo,
    'payType': instance.payType,
    'thirdPartFlag': instance.thirdPartFlag,
    'transFlag': instance.transFlag,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isCombined', instance.isCombined);
  writeNotNull('transaction', instance.transaction?.toJson());
  return val;
}

CashierConfirmTransaction _$CashierConfirmTransactionFromJson(Map json) {
  return CashierConfirmTransaction(
    amt: (json['amt'] as num).toDouble(),
    orderNo: json['orderNo'] as String,
    originAmount: (json['originAmount'] as num).toDouble(),
    payType: json['payType'] as int,
    terminalSn: json['terminalSn'] as String,
    transactionStatus: json['transactionStatus'] as int,
    transNo: json['transNo'] as String,
    authCode: json['authCode'] as String?,
    oldAmount: (json['oldAmount'] as num?)?.toDouble(),
    batchNo: json['batchNo'] as String?,
    cardNo: json['cardNo'] as String?,
    cardinPutMethod: json['cardinPutMethod'] as String?,
    merchantName: json['merchantName'] as String?,
    merchantOrderNo: json['merchantOrderNo'] as String?,
    operatorId: json['operatorId'] as String?,
    refNo: json['refNo'] as String?,
    remark: json['remark'] as String?,
    scanOrderId: json['scanOrderId'] as String?,
    traceNo: json['traceNo'] as String?,
    transDate: json['transDate'] as String?,
    transTime: json['transTime'] as String?,
    transType: json['transType'] as String?,
    unionNo: json['unionNo'] as String?,
  );
}

Map<String, dynamic> _$CashierConfirmTransactionToJson(
    CashierConfirmTransaction instance) {
  final val = <String, dynamic>{
    'amt': instance.amt,
    'orderNo': instance.orderNo,
    'originAmount': instance.originAmount,
    'payType': instance.payType,
    'terminalSn': instance.terminalSn,
    'transactionStatus': instance.transactionStatus,
    'transNo': instance.transNo,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('authCode', instance.authCode);
  writeNotNull('oldAmount', instance.oldAmount);
  writeNotNull('batchNo', instance.batchNo);
  writeNotNull('cardNo', instance.cardNo);
  writeNotNull('cardinPutMethod', instance.cardinPutMethod);
  writeNotNull('merchantName', instance.merchantName);
  writeNotNull('merchantOrderNo', instance.merchantOrderNo);
  writeNotNull('operatorId', instance.operatorId);
  writeNotNull('refNo', instance.refNo);
  writeNotNull('remark', instance.remark);
  writeNotNull('scanOrderId', instance.scanOrderId);
  writeNotNull('traceNo', instance.traceNo);
  writeNotNull('transDate', instance.transDate);
  writeNotNull('transTime', instance.transTime);
  writeNotNull('transType', instance.transType);
  writeNotNull('unionNo', instance.unionNo);
  return val;
}

CashierRefund _$CashierRefundFromJson(Map json) {
  return CashierRefund(
    CashierRefundOrder.fromJson(
        Map<String, dynamic>.from(json['order'] as Map)),
    (json['productInfoList'] as List<dynamic>)
        .map((e) =>
            CashierRefundProduct.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$CashierRefundToJson(CashierRefund instance) =>
    <String, dynamic>{
      'order': instance.order.toJson(),
      'productInfoList':
          instance.productInfoList.map((e) => e.toJson()).toList(),
    };

CashierRefundOrder _$CashierRefundOrderFromJson(Map json) {
  return CashierRefundOrder(
    amt: (json['amt'] as num).toDouble(),
    orderSource: json['orderSource'] as int,
    cashierId: json['cashierId'] as int?,
    terminalSn: json['terminalSn'] as String?,
    thirdPartFlag: json['thirdPartFlag'] as int?,
    remark: json['remark'] as String?,
  );
}

Map<String, dynamic> _$CashierRefundOrderToJson(CashierRefundOrder instance) {
  final val = <String, dynamic>{
    'amt': instance.amt,
    'orderSource': instance.orderSource,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cashierId', instance.cashierId);
  writeNotNull('terminalSn', instance.terminalSn);
  writeNotNull('thirdPartFlag', instance.thirdPartFlag);
  writeNotNull('remark', instance.remark);
  return val;
}

CashierRefundProduct _$CashierRefundProductFromJson(Map json) {
  return CashierRefundProduct(
    changeNumber: (json['changeNumber'] as num).toDouble(),
    unitPrice: (json['unitPrice'] as num).toDouble(),
    productId: json['productId'] as int,
    productName: json['productName'] as String,
    remark: json['remark'] as String?,
  );
}

Map<String, dynamic> _$CashierRefundProductToJson(
    CashierRefundProduct instance) {
  final val = <String, dynamic>{
    'changeNumber': instance.changeNumber,
    'unitPrice': instance.unitPrice,
    'productId': instance.productId,
    'productName': instance.productName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('remark', instance.remark);
  return val;
}

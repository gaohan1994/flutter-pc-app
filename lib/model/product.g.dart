// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map json) {
  return ProductList(
    (json['rows'] as List<dynamic>)
        .map((e) => ProductInfo.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    json['total'] as int,
  );
}

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };

ProductInfo _$ProductInfoFromJson(Map json) {
  return ProductInfo(
    json['barcode'] as String?,
    json['brand'] as String?,
    json['createTime'] as String?,
    json['customer'] as int?,
    json['id'] as int,
    (json['memberPrice'] as num?)?.toDouble(),
    json['name'] as String,
    (json['number'] as num?)?.toDouble(),
    (json['price'] as num).toDouble(),
    (json['saleNumber'] as num?)?.toDouble(),
    json['standard'] as String?,
    json['status'] as int?,
    json['typeId'] as int?,
    json['typeName'] as String?,
    json['unit'] as String?,
  )
    ..pic = json['pic'] as String?
    ..saleType = json['saleType'] as int?
    ..sellNum = (json['sellNum'] as num?)?.toDouble()
    ..remark = json['remark'] as String?
    ..pointDiscount = (json['pointDiscount'] as num?)?.toDouble()
    ..unitPrice = (json['unitPrice'] as num?)?.toDouble()
    ..priceChangeFlag = json['priceChangeFlag'] as bool?
    ..productName = json['productName'] as String?;
}

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('number', instance.number);
  writeNotNull('pic', instance.pic);
  writeNotNull('barcode', instance.barcode);
  val['price'] = instance.price;
  writeNotNull('brand', instance.brand);
  writeNotNull('createTime', instance.createTime);
  writeNotNull('customer', instance.customer);
  writeNotNull('memberPrice', instance.memberPrice);
  writeNotNull('saleNumber', instance.saleNumber);
  writeNotNull('standard', instance.standard);
  writeNotNull('status', instance.status);
  writeNotNull('typeId', instance.typeId);
  writeNotNull('typeName', instance.typeName);
  writeNotNull('unit', instance.unit);
  writeNotNull('saleType', instance.saleType);
  writeNotNull('sellNum', instance.sellNum);
  writeNotNull('remark', instance.remark);
  writeNotNull('pointDiscount', instance.pointDiscount);
  writeNotNull('unitPrice', instance.unitPrice);
  writeNotNull('priceChangeFlag', instance.priceChangeFlag);
  writeNotNull('productName', instance.productName);
  return val;
}

ProductTypeList _$ProductTypeListFromJson(Map json) {
  return ProductTypeList(
    (json['data'] as List<dynamic>)
        .map((e) => ProductType.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$ProductTypeListToJson(ProductTypeList instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

ProductType _$ProductTypeFromJson(Map json) {
  return ProductType(
    json['id'] as int,
    json['parentId'] as int?,
    json['name'] as String,
    (json['subCategory'] as List<dynamic>?)
        ?.map((e) => ProductType.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  )..isDefault = json['isDefault'] as int?;
}

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('parentId', instance.parentId);
  val['name'] = instance.name;
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull(
      'subCategory', instance.subCategory?.map((e) => e.toJson()).toList());
  return val;
}

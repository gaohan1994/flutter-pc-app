// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) {
  return ProductList(
    (json['rows'] as List<dynamic>)
        .map((e) => ProductInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int,
  );
}

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows,
    };

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) {
  return ProductInfo(
    json['barcode'] as String,
    json['brand'] as String?,
    json['createTime'] as String?,
    json['customer'] as int?,
    json['id'] as int,
    (json['memberPrice'] as num?)?.toDouble(),
    json['name'] as String,
    (json['number'] as num).toDouble(),
    json['pic'] as String,
    (json['price'] as num).toDouble(),
    (json['saleNumber'] as num?)?.toDouble(),
    json['standard'] as String?,
    json['status'] as int?,
    json['typeId'] as int?,
    json['typeName'] as String?,
    json['unit'] as String?,
  );
}

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'pic': instance.pic,
      'barcode': instance.barcode,
      'price': instance.price,
      'brand': instance.brand,
      'createTime': instance.createTime,
      'customer': instance.customer,
      'memberPrice': instance.memberPrice,
      'saleNumber': instance.saleNumber,
      'standard': instance.standard,
      'status': instance.status,
      'typeId': instance.typeId,
      'typeName': instance.typeName,
      'unit': instance.unit,
    };

ProductTypeList _$ProductTypeListFromJson(Map<String, dynamic> json) {
  return ProductTypeList(
    (json['data'] as List<dynamic>)
        .map((e) => ProductType.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProductTypeListToJson(ProductTypeList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) {
  return ProductType(
    json['id'] as int,
    json['parentId'] as int?,
    json['name'] as String,
    (json['subCategory'] as List<dynamic>?)
        ?.map((e) => ProductType.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'name': instance.name,
      'subCategory': instance.subCategory,
    };

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
    json['id'] as int,
    json['name'] as String,
    (json['price'] as num).toDouble(),
  )
    ..number = (json['number'] as num?)?.toDouble()
    ..pic = json['pic'] as String?
    ..barcode = json['barcode'] as String?
    ..brand = json['brand'] as String?
    ..createTime = json['createTime'] as String?
    ..customer = json['customer'] as int?
    ..memberPrice = (json['memberPrice'] as num?)?.toDouble()
    ..saleNumber = (json['saleNumber'] as num?)?.toDouble()
    ..standard = json['standard'] as String?
    ..status = json['status'] as int?
    ..typeName = json['typeName'] as String?
    ..unit = json['unit'] as String?
    ..saleType = json['saleType'] as int?
    ..sellNum = (json['sellNum'] as num?)?.toDouble()
    ..remark = json['remark'] as String?
    ..pointDiscount = (json['pointDiscount'] as num?)?.toDouble()
    ..unitPrice = (json['unitPrice'] as num?)?.toDouble()
    ..priceChangeFlag = json['priceChangeFlag'] as bool?
    ..productName = json['productName'] as String?
    ..activityInfos = json['activityInfos'] as List<dynamic>?
    ..enableMemberDiscount = json['enableMemberDiscount'] as bool?
    ..pictures =
        (json['pictures'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..createBy = json['createBy'] as String?
    ..customInfo = json['customInfo'] as String?
    ..description = json['description'] as String?
    ..nameAbbr = json['nameAbbr'] as String?
    ..shareImagePath = json['shareImagePath'] as String?
    ..supplierName = json['supplierName'] as String?
    ..updateBy = json['updateBy'] as String?
    ..updateTime = json['updateTime'] as String?
    ..cost = (json['cost'] as num?)?.toDouble()
    ..isDeleted = json['isDeleted'] as int?
    ..limitNum = (json['limitNum'] as num?)?.toDouble()
    ..merchantId = json['merchantId'] as int?
    ..perCost = (json['perCost'] as num?)?.toDouble()
    ..supplierId = json['supplierId'] as int?
    ..type = json['type'] as int?
    ..wholesalePrice = (json['wholesalePrice'] as num?)?.toDouble()
    ..isHelpPool = json['isHelpPool'] as int?
    ..imgPaths = json['imgPaths'] as String?;
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
  writeNotNull('typeName', instance.typeName);
  writeNotNull('unit', instance.unit);
  writeNotNull('saleType', instance.saleType);
  writeNotNull('sellNum', instance.sellNum);
  writeNotNull('remark', instance.remark);
  writeNotNull('pointDiscount', instance.pointDiscount);
  writeNotNull('unitPrice', instance.unitPrice);
  writeNotNull('priceChangeFlag', instance.priceChangeFlag);
  writeNotNull('productName', instance.productName);
  writeNotNull('activityInfos', instance.activityInfos);
  writeNotNull('enableMemberDiscount', instance.enableMemberDiscount);
  writeNotNull('pictures', instance.pictures);
  writeNotNull('createBy', instance.createBy);
  writeNotNull('customInfo', instance.customInfo);
  writeNotNull('description', instance.description);
  writeNotNull('nameAbbr', instance.nameAbbr);
  writeNotNull('shareImagePath', instance.shareImagePath);
  writeNotNull('supplierName', instance.supplierName);
  writeNotNull('updateBy', instance.updateBy);
  writeNotNull('updateTime', instance.updateTime);
  writeNotNull('cost', instance.cost);
  writeNotNull('isDeleted', instance.isDeleted);
  writeNotNull('limitNum', instance.limitNum);
  writeNotNull('merchantId', instance.merchantId);
  writeNotNull('perCost', instance.perCost);
  writeNotNull('supplierId', instance.supplierId);
  writeNotNull('type', instance.type);
  writeNotNull('wholesalePrice', instance.wholesalePrice);
  writeNotNull('isHelpPool', instance.isHelpPool);
  writeNotNull('imgPaths', instance.imgPaths);
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

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductList {
  ProductList(this.rows, this.total);

  int total;

  List<ProductInfo> rows;

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  toJson() => _$ProductListToJson(this);
}

@JsonSerializable()
class ProductInfo {
  ProductInfo({
    this.id,
    required this.name,
    required this.price,
    this.number,
    this.pic,
    this.barcode,
    this.brand,
    this.createTime,
    this.customer,
    this.memberPrice,
    this.saleNumber,
    this.standard,
    this.status,
    this.typeName,
    this.unit,
    this.saleType,
    this.activityInfos,
    this.enableMemberDiscount,
    this.pictures,
    this.createBy,
    this.customInfo,
    this.description,
    this.nameAbbr,
    this.shareImagePath,
    this.supplierName,
    this.updateBy,
    this.updateTime,
    this.cost,
    this.isDeleted,
    this.limitNum,
    this.merchantId,
    this.perCost,
    this.supplierId,
    this.type,
    this.wholesalePrice,
    this.isHelpPool,
    this.imgPaths,
    this.sellNum,
    this.remark,
    this.pointDiscount,
    this.unitPrice,
    this.priceChangeFlag,
    this.productName,
  });

  int? id;
  String name;
  double? number;
  String? pic;
  String? barcode;
  double price;
  String? brand;
  String? createTime;
  int? customer;
  double? memberPrice;
  double? saleNumber;
  String? standard;
  int? status;
  String? typeName;
  String? unit;
  int? saleType;

  // 数量
  double? sellNum;
  // 备注
  String? remark;
  // 积分折扣
  double? pointDiscount;
  // 改价/无码商品参加满减或优惠券前的价格
  double? unitPrice;
  // 改价标识
  bool? priceChangeFlag;
  // 商品名称,无码商品需要填写
  String? productName;

  List<dynamic>? activityInfos;
  bool? enableMemberDiscount;
  List<String>? pictures;
  String? createBy;
  String? customInfo;
  String? description;
  String? nameAbbr;
  String? shareImagePath;
  String? supplierName;
  String? updateBy;
  String? updateTime;
  double? cost;
  int? isDeleted;
  double? limitNum;
  int? merchantId;
  double? perCost;
  int? supplierId;
  int? type;
  double? wholesalePrice;
  int? isHelpPool;
  String? imgPaths;

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

  toJson() => _$ProductInfoToJson(this);
}

class ProductInfoDetail {
  ProductInfoDetail();
}

@JsonSerializable()
class ProductTypeList {
  ProductTypeList(this.data);
  List<ProductType> data;

  factory ProductTypeList.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeListFromJson(json);

  toJson() => _$ProductTypeListToJson(this);
}

@JsonSerializable()
class ProductType {
  ProductType(
    this.id,
    this.parentId,
    this.name,
    this.subCategory,
  );

  int id;
  int? parentId;
  String name;
  int? isDefault;
  List<ProductType>? subCategory;

  factory ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);

  toJson() => _$ProductTypeToJson(this);
}

@JsonSerializable()
class ProductSupplier {
  ProductSupplier({
    required this.name,
    required this.id,
    this.address,
    this.contactName,
    this.phoneNumber,
    this.remark,
    this.isDefault,
  });
  String name;
  int id;
  String? address;
  String? contactName;
  String? phoneNumber;
  String? remark;
  int? isDefault;

  factory ProductSupplier.fromJson(Map<String, dynamic> json) =>
      _$ProductSupplierFromJson(json);

  toJson() => _$ProductSupplierToJson(this);
}

@JsonSerializable()
class ProductSupplierList {
  ProductSupplierList(this.data);
  List<ProductSupplier> data;

  factory ProductSupplierList.fromJson(Map<String, dynamic> json) =>
      _$ProductSupplierListFromJson(json);

  toJson() => _$ProductSupplierListToJson(this);
}

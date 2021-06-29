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
  ProductInfo(
    this.id,
    this.name,
    this.price,
  );

  int id;
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

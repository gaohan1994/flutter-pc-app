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
    this.barcode,
    this.brand,
    this.createTime,
    this.customer,
    this.id,
    this.memberPrice,
    this.name,
    this.number,
    // this.pic,
    this.price,
    this.saleNumber,
    this.standard,
    this.status,
    this.typeId,
    this.typeName,
    this.unit,
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
  int? typeId;
  String? typeName;
  String? unit;

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

  toJson() => _$ProductInfoToJson(this);
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
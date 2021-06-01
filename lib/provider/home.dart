import 'package:flutter/material.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/service/product_method.dart';
import 'dart:convert';

class HomePageProvider extends ChangeNotifier {
  // 页数
  int page = 1;
  // 页码
  int pageSize = 20;

  // 选中的商品分类
  int _selectedProductType = -1;
  get selectedProductType => _selectedProductType;

  // 商品分类
  List<ProductType> _productsType = [];
  List<ProductType> get productsType => _productsType;

  // 商品列表
  List<ProductInfo> _productsList = [];
  List<ProductInfo> get productsList => _productsList;

  void switchProductTtype(int typeId) {
    _selectedProductType = typeId;
    getProducts();
    notifyListeners();
  }

  // 请求列表，过程很繁琐 用心感受
  Future<void> getProducts() async {
    var params = {
      "pageNum": 1,
      "pageSize": pageSize,
      "type": "${_selectedProductType}"
    };

    print('---请求商品分类--:${_selectedProductType}');
    var result = await productInfoList(params: params);
    var resultMap = json.decode(result.toString());

    var productRows = ProductList.fromJson(resultMap['data']).rows;
    _productsList = productRows;
    page = 1;
    notifyListeners();
  }

  // 加载更多商品
  Future loadMoreProducts() async {
    var params = {
      "pageNum": page + 1,
      "pageSize": pageSize,
      "type": "${_selectedProductType}"
    };
    var result = await productInfoList(params: params);
    var resultMap = json.decode(result.toString());

    var newList = ProductList.fromJson(resultMap['data']).rows;
    _productsList.addAll(newList);
    page++;
    notifyListeners();
  }

  // 请求商品分类
  Future getProductType() async {
    var result = await productInfoType();
    var resultMap = json.decode(result.toString());

    _productsType = ProductTypeList.fromJson(resultMap).data;
    // 设置默认选中 isDefault = 1 的分类
    var defaultSelectedType =
        _productsType.firstWhere((_type) => _type.isDefault == 1);
    _selectedProductType = defaultSelectedType.id;
    notifyListeners();
    return _productsType;
  }
}

import 'package:flutter/material.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/service/product_method.dart';
import 'dart:convert';

class HomePageProvider extends ChangeNotifier {
  // 页数
  int page = 1;
  // 页码
  int pageSize = 20;

  // 商品分类
  List<ProductType> _productsType = [];
  // 商品列表
  List<ProductInfo> _productsList = [];

  // 请求列表，过程很繁琐 用心感受
  Future<void> getProducts() async {
    var params = {"pageNum": 1, "pageSize": pageSize};
    var result = await productInfoList(params: params);
    var resultMap = json.decode(result.toString());

    var productRows = ProductList.fromJson(resultMap['data']).rows;
    _productsList = productRows;
    page = 1;
    notifyListeners();
  }

  // 加载更多商品
  Future loadMoreProducts() async {
    var params = {'pageNum': page + 1, 'pageSize': pageSize};
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
    notifyListeners();
  }

  List<ProductInfo> get productsList => _productsList;

  List<ProductType> get productsType => _productsType;
}
